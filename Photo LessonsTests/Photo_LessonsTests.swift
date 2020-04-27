//
//  Photo_LessonsTests.swift
//  Photo LessonsTests
//
//  Created by Gabe Guerrero on 4/27/20.
//  Copyright © 2020 Gabriel Guerrero. All rights reserved.
//

import XCTest
@testable import Photo_Lessons

class Photo_LessonsTests: XCTestCase {
    var manager: LessonManager?
    var mockLessonList = [Lesson]()
    
    let jsonString = """
    {
        "videos": [
            {
                "id": 950,
                "name": "How To Hold Your iPhone When Taking Photos",
                "thumbnail": "https://i.picsum.photos/id/477/2000/2000.jpg",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
            },
            {
                "id": 7991,
                "name": "3 Quick Ways To Open The iPhone Camera App",
                "thumbnail": "https://i.picsum.photos/id/254/2000/2000.jpg",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
            },
            {
                "id": 1486,
                "name": "5 Unique Ways To Release The iPhone's Shutter",
                "thumbnail": "https://i.picsum.photos/id/334/2000/2000.jpg",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
            },
            {
                "id": 3657,
                "name": "3 Secret iPhone Camera Features For Perfect Focus",
                "thumbnail": "https://i.picsum.photos/id/37/2000/2000.jpg",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
            },
            {
                "id": 400,
                "name": "Setting The Correct Exposure For Well-Lit iPhone Photos",
                "thumbnail": "https://i.picsum.photos/id/496/2000/2000.jpg",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
            },
            {
                "id": 851,
                "name": "How To Pick The Correct iPhone Camera Settings",
                "thumbnail": "https://i.picsum.photos/id/264/2000/2000.jpg",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
            },
            {
                "id": 3722,
                "name": "How To Capture Action Shots Using Burst Mode",
                "thumbnail": "https://i.picsum.photos/id/374/2000/2000.jpg",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
            },
            {
                "id": 3679,
                "name": "How To Use HDR For Taking Evenly Exposed Photos",
                "thumbnail": "https://i.picsum.photos/id/394/2000/2000.jpg",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
            },
            {
                "id": 2372,
                "name": "How To Take Outstanding Panoramic Photos With Your iPhone",
                "thumbnail": "https://i.picsum.photos/id/292/2000/2000.jpg",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
            },
            {
                "id": 4850,
                "name": "How To Expand Your Creativity With Live Photos [iPhone 6S Or Newer]",
                "thumbnail": "https://i.picsum.photos/id/456/2000/2000.jpg",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
            },
            {
                "id": 5630,
                "name": "How To Use The Dual Lens Camera [iPhone 7 Plus, 8 Plus, X, XS, XS Max, 11 Pro & 11 Pro Max]",
                "thumbnail": "https://i.picsum.photos/id/281/2000/2000.jpg",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
            },
            {
                "id": 1481,
                "name": "How To Use The Portrait Mode [iPhone XS, XS Max, XR, 11, 11 Pro & 11 Pro Max]",
                "thumbnail": "https://i.picsum.photos/id/362/2000/2000.jpg",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
            },
            {
                "id": 1045,
                "name": "How To Use The Portrait Mode [iPhone 7 Plus, 8 Plus & X]",
                "thumbnail": "https://i.picsum.photos/id/414/2000/2000.jpg",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
            },
            {
                "id": 6230,
                "name": "Portrait Lighting Effects [iPhone 8 Plus & X]",
                "thumbnail": "https://i.picsum.photos/id/123/2000/2000.jpg",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
            }
        ]
    }
    """

        
    override func setUp() {
        manager = LessonManager()
        
        let response = try! JSONDecoder().decode(Response.self, from: jsonString.data(using: .utf8)!)
        if let lessons = response.lessons {
            mockLessonList = lessons
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        manager = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageCaching() {
        guard let image = UIImage(systemName: "photo") else { return }
        let time = Date.timeIntervalSinceReferenceDate
        let mockKey = "hourglass\(time).jpg"
        XCTAssertNotNil(image)
        LessonManager.cacheImage(image: image, forKey: mockKey)
        let retrievedImage = LessonManager.getImage(forKey: mockKey)
        XCTAssertNotNil(retrievedImage)
    }
    
    func testHandleJSONString() {
        manager?.lessons = []
        guard let manager = manager else { return }
        manager.lessonDownloadCallback = {
            XCTAssert(!manager.lessons.isEmpty)
            for i in 0..<self.mockLessonList.count {
                XCTAssert(self.mockLessonList[i].id == manager.lessons[i].id)
                XCTAssert(self.mockLessonList[i].name == manager.lessons[i].name)
                XCTAssert(self.mockLessonList[i].thumbURL == manager.lessons[i].thumbURL)
                XCTAssert(self.mockLessonList[i].description == manager.lessons[i].description)
                XCTAssert(self.mockLessonList[i].videoURL == manager.lessons[i].videoURL)
            }
        }
    
        manager.handleJSONString(jsonString)
    }
    
    func testHandleData() {
        manager?.lessons = []
        guard let manager = manager else { return }
        manager.lessonDownloadCallback = {
            XCTAssert(!manager.lessons.isEmpty)
            for i in 0..<self.mockLessonList.count {
                XCTAssert(self.mockLessonList[i].id == manager.lessons[i].id)
                XCTAssert(self.mockLessonList[i].name == manager.lessons[i].name)
                XCTAssert(self.mockLessonList[i].thumbURL == manager.lessons[i].thumbURL)
                XCTAssert(self.mockLessonList[i].description == manager.lessons[i].description)
                XCTAssert(self.mockLessonList[i].videoURL == manager.lessons[i].videoURL)
            }
        }
        
        let jsonData = jsonString.data(using: .utf8)
        manager.handleData(data: jsonData)
    }
    
    func testGetAlbums() {
        guard let manager = manager else { return }
        manager.getLessons()
        manager.lessonDownloadCallback = {
            XCTAssert(!manager.lessons.isEmpty)
            for i in 0..<self.mockLessonList.count {
                XCTAssert(self.mockLessonList[i].id == manager.lessons[i].id)
                XCTAssert(self.mockLessonList[i].name == manager.lessons[i].name)
                XCTAssert(self.mockLessonList[i].thumbURL == manager.lessons[i].thumbURL)
                XCTAssert(self.mockLessonList[i].description == manager.lessons[i].description)
                XCTAssert(self.mockLessonList[i].videoURL == manager.lessons[i].videoURL)
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
