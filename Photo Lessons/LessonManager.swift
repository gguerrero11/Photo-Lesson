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
import AVKit

class LessonManager: ObservableObject {
    @Published var lessons = [Lesson]()
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
    
    /// Cache the image. The return is an optional, if it returns nil, the image was not found.
    ///
    /// By storing the image into the file manager, we don't have to store images on UserDefaults (as we shouldn't).
    /// This allows us to just save the path of the image (stored on the device) into UserDefaults to use
    ///
    /// - Parameter image: The image to be cached
    /// - Parameter forPath: The key to cache the image. In this case, the URL of the image.
    
    static func cacheImage(image: UIImage, forKey key: String) {
        let imageData = image.jpegData(compressionQuality: 1)
        let relativePath = "image_\(Date.timeIntervalSinceReferenceDate).jpg"
        let cachePath = LessonManager.documentsPathForFileName(name: relativePath)
        let url = URL(fileURLWithPath: cachePath)
        do {
            try imageData?.write(to: url, options: .atomic)
            UserDefaults.standard.set(relativePath, forKey: key)
            UserDefaults.standard.synchronize()
        } catch {
            print("error caching")
        }
    }
    
    /// Cache the video. The return is an optional, if it returns nil, the video was not found.
    ///
    /// By storing the image into the file manager, we don't have to store images on UserDefaults (as we shouldn't).
    /// This allows us to just save the path of the image (stored on the device) into UserDefaults to use
    ///
    /// - Parameter video: The video to be cached
    /// - Parameter forPath: The key to cache the image. In this case, the URL of the image.
    
    static func cacheVideo(stringURL: String, forKey key: String) {
//        let relativePath = "video_\(Date.timeIntervalSinceReferenceDate).mov"
//        let cachePath = LessonManager.documentsPathForFileName(name: relativePath)
//        let url = URL(fileURLWithPath: cachePath)
//        print("caching at \(url)")
//
//        // asset is you AVAsset object
//        let exportSession = AVAssetExportSession.init(asset: video, presetName: AVAssetExportPresetHighestQuality)
//        exportSession?.outputURL = url
//        exportSession?.outputFileType = .mov
//        exportSession?.exportAsynchronously {
            UserDefaults.standard.set(stringURL, forKey: key)
            UserDefaults.standard.synchronize()
//        }
    }
    
    /// Finds the image in the cache. The return is an optional, if it returns nil, the image was not found.
    ///
    /// By using the key (in this case the web URL of the image), we can see if there is a path to the local drive
    /// of this image. If it is present then it will go look for the image in FileManager and return it.
    ///
    /// - Parameter key: The key to get the image. In this case, the URL
    /// - Returns: The image
    
    static func getImage(forKey key: String) -> UIImage? {
        var image: UIImage?
        let possibleOldImagePath = UserDefaults.standard.object(forKey: key) as? String
        if let oldImagePath = possibleOldImagePath {
            let oldFullPath = LessonManager.documentsPathForFileName(name: oldImagePath)
            let url = URL(fileURLWithPath: oldFullPath)
            do {
                let oldImageData = try Data(contentsOf: url)
                image = UIImage(data: oldImageData)
            } catch {
                print("error getting cached Image")
            }
        }
        
        return image
    }
    
    /// Finds the video in the cache. The return is an optional, if it returns nil, the video was not found.
    ///
    /// By using the key (in this case the web URL of the image), we can see if there is a path to the local drive
    /// of this video. If it is present then it will go look for the video in FileManager and return it.
    ///
    /// - Parameter key: The key to get the image. In this case, the URL
    /// - Returns: The video location
    
    static func getVideo(forKey key: String) -> URL? {
        if let location = UserDefaults.standard.value(forKey: key) as? String {
            if let url = URL(string: location) {
                return url
            }
        }
        return nil
    }

    
    /// Gets the path for the store imaged directory
    ///
    /// - Parameter name: The key to image.
    /// - Returns: The relative path to the directory
    static func documentsPathForFileName(name: String) -> String {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = paths[0]
        let fullPath = path.appendingPathComponent(name)
        return fullPath.relativePath
    }
    
}

struct Response: Codable {
    var lessons: [Lesson]?
    
    enum CodingKeys: String, CodingKey {
        case lessons = "videos"
    }
}
