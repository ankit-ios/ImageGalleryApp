//
//  MockNetworkService.swift
//  ImageGalleryAppTests
//
//  Created by Ankit Sharma on 29/09/24.
//

import XCTest
import Combine
@testable import ImageGalleryApp

// Mock the NetworkService to simulate the responses
class MockNetworkService: NetworkService {
    
    var getImageListResult: IGResponse!
    
    func getImageList() async -> IGResponse {
        return getImageListResult
    }
    
    func downloadImage(_ url: String) async -> IGResponse {
        fatalError("Not needed for ImageListViewModel tests")
    }
}
