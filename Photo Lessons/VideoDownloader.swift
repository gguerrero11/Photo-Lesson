//
//  VideoDownloader.swift
//  Photo Lessons
//
//  Created by Gabe Guerrero on 5/1/20.
//  Copyright © 2020 Gabriel Guerrero. All rights reserved.
//

import SwiftUI
import Combine
import Foundation
import AVKit

struct ProgressBar: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: 10)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: 10)
                .foregroundColor(Color(UIColor.systemBlue))
            }.cornerRadius(5)
        }
    }
}

class ObservedDownloader: ObservableObject {
    let downloader = VideoDownloader()
    @Published var progress: Float = 0.0
    
    deinit {
    }
    
    init() {
        downloader.callback = {
            self.progress = Float(self.downloader.progress)
        }
    }
    
    func downloadVideo(url: URL) {
        downloader.downloadVideo(url: url)
    }
    
    func cancelDownload() {
        downloader.cancelDownload()
        downloader.progress = 0.0
    }
}

class VideoDownloader: NSObject {
    private let identifier = "downloadId"
    var progress = 0.0
    var callback: (()->Void)?
    private var cancellable: AnyCancellable?
    var downloadTask: AVAssetDownloadTask?
    var url: URL?
    
    func downloadVideo(url: URL) {
        // Create new background session configuration.
        let configuration = URLSessionConfiguration.background(withIdentifier: identifier)
        
        // Create a new AVAssetDownloadURLSession with background configuration, delegate, and queue
        let downloadSession = AVAssetDownloadURLSession(configuration: configuration,
                                                    assetDownloadDelegate: self,
                                                    delegateQueue: OperationQueue.main)
        let asset = AVURLAsset(url: url)
        
        // Create new AVAssetDownloadTask for the desired asset
        downloadTask = downloadSession.makeAssetDownloadTask(asset: asset,
                                                                 assetTitle: "title",
                                                                 assetArtworkData: nil,
                                                                 options: nil)
        downloadTask?.resume()
    }
    
    func cancelDownload() {
        downloadTask?.cancel()
    }

}

extension VideoDownloader: AVAssetDownloadDelegate {
    func urlSession(_ session: URLSession, assetDownloadTask: AVAssetDownloadTask, didLoad timeRange: CMTimeRange, totalTimeRangesLoaded loadedTimeRanges: [NSValue], timeRangeExpectedToLoad: CMTimeRange) {
        // Iterate through the loaded time ranges
        for value in loadedTimeRanges {
            // Unwrap the CMTimeRange from the NSValue
            let loadedTimeRange = value.timeRangeValue
            // Calculate the percentage of the total expected asset duration
            progress = loadedTimeRange.duration.seconds / timeRangeExpectedToLoad.duration.seconds
            print(progress)
            if let callback = callback {
                callback()
            }
        }
    }
    
    func urlSession(_ session: URLSession, assetDownloadTask: AVAssetDownloadTask, didFinishDownloadingTo location: URL) {
        let avAsset = AVAsset(url: location)
        if let key = url?.absoluteString {
            LessonManager.cacheVideo(video: avAsset, forKey: key)
        }
    }

}





