//
//  VideoPlayerView.swift
//  Photo Lessons
//
//  Created by Gabe Guerrero on 4/28/20.
//  Copyright © 2020 Gabriel Guerrero. All rights reserved.
//

import SwiftUI
import Combine
import Foundation
import AVKit
import UIKit

class VideoPlayerView: UIView {
    private let playerLayer = AVPlayerLayer()
    var player = AVPlayer()
    
    init(frame: CGRect, url: URL) {
        super.init(frame: frame)
        if let avAsset = LessonManager.getVideo(forKey: url.absoluteString) {
            print("found locally")
            player.replaceCurrentItem(with: AVPlayerItem(asset: avAsset))
        } else {
            print("streaming")
            player.replaceCurrentItem(with: AVPlayerItem(url: url))
        }
        playerLayer.player = player
        player.play()
        layer.addSublayer(playerLayer)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct PlayerView: UIViewRepresentable {
    var lesson: Lesson
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
        print("updating")
    }
    
    func makeUIView(context: Context) -> UIView {
        if let url = URL(string: lesson.videoURL) {
            return VideoPlayerView(frame: .zero, url: url)
        } else {
            let imageView = UIImageView(image: UIImage(systemName: "video.slash.fill"))
            return imageView
        }
    }
}


