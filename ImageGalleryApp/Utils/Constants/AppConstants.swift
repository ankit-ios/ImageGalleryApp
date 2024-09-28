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
