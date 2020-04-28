//
//  LessonRowView.swift
//  Photo Lessons
//
//  Created by Gabe Guerrero on 4/27/20.
//  Copyright © 2020 Gabriel Guerrero. All rights reserved.
//

import SwiftUI

struct LessonRowView: View {
    var lesson: Lesson
    
    var body: some View {
        HStack {
//            Image(systemName: "photo")
            Text(lesson.name)
            Spacer()
        }
    }
}

struct LessonRowView_Previews: PreviewProvider {
        
    static var previews: some View {
        Group {
            LessonRowView(lesson: mockLesson)
            LessonRowView(lesson: mockLesson)
        }
        .previewLayout(.fixed(width: 300, height: 70))
        
    }
}
