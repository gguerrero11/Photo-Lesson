//
//  LessonList.swift
//  Photo Lessons
//
//  Created by Gabe Guerrero on 4/28/20.
//  Copyright © 2020 Gabriel Guerrero. All rights reserved.
//

import SwiftUI

struct LessonList: View {
    var body: some View {
        List {
            LessonRowView(lesson: mockLesson)
            LessonRowView(lesson: mockLesson2)
        }
    }
}

struct LessonList_Previews: PreviewProvider {
    static var previews: some View {
        LessonList()
    }
}
