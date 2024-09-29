//
//  ImageListViewModelTests.swift
//  ImageGalleryAppTests
//
//  Created by Ankit Sharma on 29/09/24.
//

import XCTest
import Combine
@testable import ImageGalleryApp

final class ImageListViewModelTests: XCTestCase {
    
    var sut: ImageListViewModel!
    var mockNetworkService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        sut = ImageListViewModel(mockNetworkService)
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        sut = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testFetchImageListSuccess() async {
        // Arrange
        let expectedPhotos = ImageList([])
        let publisher = Just(expectedPhotos)
            .setFailureType(to: AppNetworkError.self)
            .eraseToAnyPublisher()
        
        mockNetworkService.getImageListResult = .imageList(publisher)
        
        let loadingStateExpectation = XCTestExpectation(description: "Loading state should transition correctly")
        sut.$loadingState
            .dropFirst() // Skip the initial value
            .sink { state in
                if state == .loaded {
                    loadingStateExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Act
        await sut.fetchImageList()
        
        // Assert
        await fulfillment(of: [loadingStateExpectation], timeout: 2.0)
        XCTAssertEqual(sut.loadingState, .loaded, "Expected loadingState to be 'loaded'")
        XCTAssertEqual(sut.photos.count, 0, "Expected photos to be empty")
        XCTAssertNil(sut.errorMessage, "Expected no error message")
    }
    
    func testFetchImageListFailure() async {
        // Arrange
        let errorPublisher = Fail<ImageList, AppNetworkError>(error: .invalidRequest)
            .eraseToAnyPublisher()
        
        mockNetworkService.getImageListResult = .imageList(errorPublisher)
        
        let loadingStateExpectation = XCTestExpectation(description: "Loading state should transition correctly")
        sut.$loadingState
            .dropFirst() // Skip the initial value
            .sink { state in
                if state == .error {
                    loadingStateExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Act
        await sut.fetchImageList()
        
        // Assert
        await fulfillment(of: [loadingStateExpectation], timeout: 2.0)
        XCTAssertEqual(sut.loadingState, .error, "Expected loadingState to be 'error'")
        XCTAssertNotNil(sut.errorMessage, "Expected error message")
        XCTAssertEqual(sut.errorMessage, AppNetworkError.invalidRequest.description, "Expected network failure error message")
        XCTAssertEqual(sut.photos.count, 0, "Expected no photos")
    }
    
    func testLoadingStateTransitions() async {
        // Arrange
        let expectedPhotos = ImageList([])
        let publisher = Just(expectedPhotos)
            .setFailureType(to: AppNetworkError.self)
            .eraseToAnyPublisher()
        
        mockNetworkService.getImageListResult = .imageList(publisher)
        
        let loadingStateExpectation = XCTestExpectation(description: "Loading state should transition correctly")
        
        sut.$loadingState
            .dropFirst() // Skip the initial value
            .sink { state in
                if state == .loaded {
                    loadingStateExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Act
        await sut.fetchImageList()
        
        // Assert
        await fulfillment(of: [loadingStateExpectation], timeout: 2.0)
        XCTAssertEqual(sut.loadingState, .loaded, "Expected loadingState to be 'loaded' after fetch")
    }
}

