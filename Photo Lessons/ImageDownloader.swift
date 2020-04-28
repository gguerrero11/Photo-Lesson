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

class ImageDownloader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    
    private var cancellable: AnyCancellable?
    
    deinit {
        cancellable?.cancel()
    }

    init(url: URL) {
        self.url = url
    }
    
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    func cancel() {
        cancellable?.cancel()
    }
}

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var downloader: ImageDownloader
    private let placeholder: Placeholder?
    
    init(url: URL, placeholder: Placeholder? = nil) {
        downloader = ImageDownloader(url: url)
        self.placeholder = placeholder
    }

    var body: some View {
        image
            .onAppear(perform: downloader.load)
            .onDisappear(perform: downloader.cancel)
            .frame(width: 50, height: 50, alignment: .center)
            .cornerRadius(50/4)
        
    }
    
    private var image: some View {
        Group {
            if downloader.image != nil {
                Image(uiImage: downloader.image!)
                .resizable()
            } else {
                placeholder
            }
        }
    }
}
