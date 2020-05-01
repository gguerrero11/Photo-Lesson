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
            //            let location = "Library/com.apple.UserManagedAssets.ecjvdO/title_DDC97A063F825EBA.movpkg -- file:///private/var/mobile/Containers/Data/Application/CDAB3958-FF2E-497A-AEC7-E971E58B0C9C/"
            //            let location = "Library/com.apple.UserManagedAssets.ecjvdO/title_DDC97A063F825EBA.movpkg"
            //            let location = "Library/com.apple.UserManagedAssets.ecjvdO/title_DDC97A063F825EBA.movpkg -- file:///private/var/mobile/Containers/Data/Application/CDAB3958-FF2E-497A-AEC7-E971E58B0C9C/"
            //                let url = URL(string: "file:///var/mobile/Containers/Data/Application/643332EE-253A-44BC-BEE1-73D0CB451F82/Documents/video_610058499.460731.mov")
            //            let url = URL(string: location)
            //            player.replaceCurrentItem(with: AVPlayerItem(url: url!))
            player.replaceCurrentItem(with: AVPlayerItem(asset: avAsset))
        } else {
            print("streaming")
            player.replaceCurrentItem(with: AVPlayerItem(url: url))
        }
        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }
    
    func play() {
        player.play()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct PlayerViewRepresentable: UIViewRepresentable {
    var player: VideoPlayerView?
    
    init(lesson: Lesson) {
        if let url = URL(string: lesson.videoURL) {
            player = VideoPlayerView(frame: .zero, url: url)
        }
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerViewRepresentable>) {
    }
    
    func makeUIView(context: Context) -> UIView {
        if let player = player {
            return player
        } else {
            let imageView = UIImageView(image: UIImage(systemName: "video.slash.fill"))
            return imageView
        }
    }
    
    func play() {
        guard let player = player else { return }
        player.play()
    }
}

struct PlayerView: View {
    @Environment(\.imageStore) var store: ImageStore
    @State var isPlaying = false
    private var lesson: Lesson
    private var playerRep: PlayerViewRepresentable
    
    init(lesson: Lesson) {
        self.lesson = lesson
        playerRep = PlayerViewRepresentable(lesson: lesson)
    }
    
    var body: some View {
        ZStack {
            if isPlaying {
                playerRep
            } else {
                AsyncImage(urlString: self.lesson.thumbURL,
                           errorImage: Image(systemName: "video.slash.fill"),
                           store: self.store)
                    .frame(width: 325, height: 250, alignment: .center)
                Button(action: {
                    self.playerRep.play()
                    self.isPlaying = true
                }) {
                    Image(systemName: "play.circle")
                        .resizable()
                        .foregroundColor(.white)
                        .scaledToFit()
                }.frame(width: 50, height: 50, alignment: .center)
                    .shadow(radius: 20)
            }
        }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
    
}


