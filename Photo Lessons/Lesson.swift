//
//  Lesson.swift
//  Photo Lessons
//
//  Created by Gabe Guerrero on 4/27/20.
//  Copyright © 2020 Gabriel Guerrero. All rights reserved.
//

import Foundation

struct Lesson: Codable {
    var id: Int
    var name: String
    var thumbURL: String
    var description: String
    var videoURL: String
    
    init(_ id: Int, _ name: String, _ thumbURL: String, _ description: String, _ videoURL: String) {
        self.id = id
        self.name = name
        self.thumbURL = thumbURL
        self.description = description
        self.videoURL = videoURL
    }
    
    enum CodingKeys: String, CodingKey {
        case id             = "id"
        case name           = "name"
        case thumbURL       = "thumbnail"
        case description    = "description"
        case videoURL       = "video_link"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        thumbURL = try container.decode(String.self, forKey: .thumbURL)
        description = try container.decode(String.self, forKey: .description)
        videoURL = try container.decode(String.self, forKey: .videoURL)
    
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
}

