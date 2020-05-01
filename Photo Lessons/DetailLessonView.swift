//
//  DetailLessonView.swift
//  Photo Lessons
//
//  Created by Gabe Guerrero on 4/28/20.
//  Copyright © 2020 Gabriel Guerrero. All rights reserved.
//

import SwiftUI

struct DetailLessonView: View {
    
    @ObservedObject private var downloader = ObservedDownloader()
    @Environment(\.imageStore) var store: ImageStore
    @State private var isDownloading = false
    var lesson: Lesson
    
    var body: some View {
        VStack {
            ProgressBar(value: $downloader.progress)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            PlayerView(lesson: self.lesson)
            Text(lesson.name)
                .font(.system(size: 25))
                .bold()
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            Text(lesson.description)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 5, trailing: 20))
            Spacer()
        }
        .navigationBarItems(trailing:
            HStack {
                Button(action: {
                    if self.isDownloading {
                        self.isDownloading = false
                        self.downloader.cancelDownload()
                    } else {
                        if let url = URL(string: self.lesson.videoURL) {
                            self.isDownloading = true
                            self.downloader.downloadVideo(url: url)
                        }
                    }
                }) {
                    Text(isDownloading ? "Cancel download" : "Download video")
                }
                Image(systemName: "square.and.arrow.down")
                    .foregroundColor(.blue)
                    
            }
        )
    }
}

struct DetailLessonView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLessonView(lesson: mockLesson)
    }
}
