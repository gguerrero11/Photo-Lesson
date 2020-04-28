//
//  Utility.swift
//  Photo Lessons
//
//  Created by Gabe Guerrero on 4/28/20.
//  Copyright © 2020 Gabriel Guerrero. All rights reserved.
//

import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageStore = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageStore: ImageStore {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
