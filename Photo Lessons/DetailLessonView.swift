//
//  DetailLessonView.swift
//  Photo Lessons
//
//  Created by Gabe Guerrero on 4/28/20.
//  Copyright © 2020 Gabriel Guerrero. All rights reserved.
//

import SwiftUI

struct DetailLessonView: View {
    var lesson: Lesson
    var body: some View {
            VStack {
                HStack(alignment: .center) {
                    AsyncImage(urlString: lesson.thumbURL,
                               errorImage: Image(systemName: "video.slash.fill")
                    )
                        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 1.5, alignment: .center)
                }
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
                    Button("Download video") {
                        print("download tapped!")
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
