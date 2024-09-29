//
//  IGApi.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import Foundation

//MARK: - API requests
// IG is short form of ImageGallery
enum IGApi: ApiRequest {
    
    case imageList
    case imageDetail ///Currently we're using it this API, we can use it for future scope of leveraging
    
    var endpoint: String {
        switch self {
        case .imageList: return "/photos"
        case .imageDetail: return "/imageDetail"
        }
    }
    
    var requestParameters: [String: Any]? {
        switch self {
        default: return nil
        }
    }
}
