//
//  LessonList.swift
//  Photo Lessons
//
//  Created by Gabe Guerrero on 4/28/20.
//  Copyright © 2020 Gabriel Guerrero. All rights reserved.
//

import SwiftUI

struct LessonList: View {
    
    @ObservedObject var manager = LessonManager()
    
    var body: some View {
        NavigationView {
            List(manager.lessons) { lesson in
                NavigationLink(destination: DetailLessonView(lesson: lesson)) {
                    LessonRowView(lesson: lesson)
                }
            }
            .navigationBarTitle("Videos")
        }
    }
}

struct LessonList_Previews: PreviewProvider {
    static var previews: some View {
        LessonList()
    }
}
