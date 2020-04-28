//
//  LessonManager.swift
//  Photo lessons
//
//  Created by Gabe Guerrero on 4/27/20.
//  Copyright © 2020 Gabriel Guerrero. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

class LessonManager: ObservableObject {
    @Published var lessons = [Lesson]()
    private var cancellable: AnyCancellable?
    let lessonsURL = "https://iphonephotographyschool.com/test-api/videos"
    let isMockData = false
    
    init() {
        getLessons()
    }
    
    func getLessons() {
        if let url = URL(string: lessonsURL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                    self.handleData(data: data)
            }.resume()
        }
    }
    
    func handleData(data: Data?) {
        if let data = data {
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
                handleJSONString(jsonString.replacingOccurrences(of: "\\", with: ""))
            }
        }
    }
    
    func handleJSONString(_ jsonString: String) {
        do {
            let jsonData = jsonString.data(using: .utf8)!
            let response = try JSONDecoder().decode(Response.self, from: jsonData)
            
            if let lessons = response.lessons {
                DispatchQueue.main.async {
                    self.lessons = lessons
                }
            }
        } catch {
            print(error)
        }
    }
        
}

struct Response: Codable {
    var lessons: [Lesson]?
    
    enum CodingKeys: String, CodingKey {
        case lessons = "videos"
    }
}
