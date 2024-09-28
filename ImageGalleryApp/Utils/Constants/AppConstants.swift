//
//  AppConstants.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import Foundation
import SwiftUI

typealias HTTPMethod = AppConstants.API.HTTPMethod

enum User: String {
    case `default` = "Guest"
}

struct AppConstants {
    
    struct API {
        static func baseURL(_ user: User = .default) -> String {
            switch user {
            case  .default: return "https://jsonplaceholder.typicode.com"
            }
        }
        
        enum HTTPMethod: String {
            case get = "GET"
            case post = "POST"
        }
    }
}

enum LoadingState {
    case idle
    case loading
    case loaded
    case error
}

struct TitleConstant {
    static let close = "Close"
    static let done = "Done"
    static let loadingDetails = "Loading Image List..."
    static let noDetailsFound = "No details found!!"
}

struct ScreenTitleConstant {
    static let imageList = "Image Gallery"
    static let imageDetail = "Image Detail"
}

struct ImageConstant {
    static let unavailable = "chart.bar.xaxis.ascending"
    static let back = "chevron.left"
}

struct SpacingConstant {
    static let spacing_2: CGFloat = 2
    static let spacing_4: CGFloat = 4
    static let spacing_10: CGFloat = 10
    static let spacing_20: CGFloat = 20
}
