//
//  ImageCachingService.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import Foundation

protocol ImageCachingService {
    func fetchCachedImage(forKey key: String) -> NSObject?
    func cacheImage(_ object: NSObject, forKey key: String)
}

final class ImageCachingManager: ImageCachingService {
    
    private let shared = NSCache<NSString, NSObject>()
    
    func fetchCachedImage(forKey key: String) -> NSObject? {
        shared.object(forKey: key as NSString)
    }
    
    func cacheImage(_ object: NSObject, forKey key: String) {
        shared.setObject(object, forKey: key as NSString)
    }
}
