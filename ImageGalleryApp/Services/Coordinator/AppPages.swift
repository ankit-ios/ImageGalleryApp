//
//  AppPages.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import Foundation

protocol Routable: Hashable, Identifiable {
    var id: String { get }
}

enum AppPages: Routable {
    
    case imageList
    case imageDetail(_ photo: Photo)
    
    var id: String {
        switch self {
        case .imageList: return "imageList"
        case .imageDetail: return "imageDetail"
        }
    }
}
