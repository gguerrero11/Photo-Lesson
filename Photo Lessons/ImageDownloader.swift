//
//  ImageDownloader.swift
//  Photo Lessons
//
//  Created by Gabe Guerrero on 4/28/20.
//  Copyright © 2020 Gabriel Guerrero. All rights reserved.
//

import SwiftUI
import Combine
import Foundation
import AVKit

/// Protocol allows us to allow subscripting for properties that conform to this
protocol ImageStore {
    subscript(_ url: URL) -> UIImage? { get set }
}

/// The struct that handles the getter/setter for the stored image
struct TemporaryImageCache: ImageStore {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}

class ImageDownloader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL?
    
    private var store: ImageStore?
    private var cancellable: AnyCancellable?
    
    deinit {
        cancellable?.cancel()
    }
    
    init(url: URL?, store: ImageStore? = nil) {
        self.url = url
        image = UIImage(systemName: "photo")
        self.store = store
    }
    
    func load() {
        // Stored image found
        if let url = self.url, let image = store?[url] {
            self.image = image
            return
        }
        
        // Download image
        if let url = url {
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .handleEvents(receiveOutput: { [weak self] in self?.store($0) })
                .receive(on: DispatchQueue.main)
                .assign(to: \.image, on: self)
        }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    private func store(_ image: UIImage?) {
        guard let url = url else { return }
        image.map { store?[url] = $0 }
    }
}

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var downloader: ImageDownloader
    private let placeholder: Placeholder?
    
    init(urlString: String?, errorImage: Placeholder? = nil, store: ImageStore) {
        if let stringURL = urlString  {
            downloader = ImageDownloader(url: URL(string: stringURL), store: store)
        } else {
            downloader = ImageDownloader(url: nil, store: store)
        }
        self.placeholder = errorImage
        
    }
    
    var body: some View {
        image
            .onAppear(perform: downloader.load)
            .onDisappear(perform: downloader.cancel)
            .cornerRadius(50/4)
    }
    
    private var image: some View {
        Group {
            if downloader.image != nil {
                Image(uiImage: downloader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                placeholder?.frame(width: 50, height: 50, alignment: .center)
            }
        }
    }
}

