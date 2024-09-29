//
//  MockApiService.swift
//  ImageGalleryAppTests
//
//  Created by Ankit Sharma on 29/09/24.
//

import XCTest
import Combine
@testable import ImageGalleryApp

// Mock ApiServiceProtocol to simulate the network calls
class MockApiService: ApiServiceProtocol {
    
    var getImageListResult: AnyPublisher<ImageList, AppNetworkError>!
    var downloadImageResult: AnyPublisher<Data, AppNetworkError>!
    
    func get<T: Decodable>(request: ApiRequest) -> AnyPublisher<T, AppNetworkError> {
        return getImageListResult as! AnyPublisher<T, AppNetworkError>
    }
    
    func get<T>(url: String) -> AnyPublisher<T, AppNetworkError> {
        return downloadImageResult as! AnyPublisher<T, AppNetworkError>
    }
}
