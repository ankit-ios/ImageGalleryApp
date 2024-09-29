//
//  ApiServiceManagerTests.swift
//  ImageGalleryAppTests
//
//  Created by Ankit Sharma on 29/09/24.
//

import XCTest
import Combine
@testable import ImageGalleryApp

final class ApiServiceManagerTests: XCTestCase {
    
    var apiServiceManager: ApiServiceManager!
    var mockApiService: MockApiService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockApiService = MockApiService()
        apiServiceManager = ApiServiceManager(apiService: mockApiService)
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        apiServiceManager = nil
        mockApiService = nil
        super.tearDown()
    }
    
    func testGetImageListSuccess() async {
        // Arrange
        let expectedImageList = ImageList([])
        mockApiService.getImageListResult = Just(expectedImageList)
            .setFailureType(to: AppNetworkError.self)
            .eraseToAnyPublisher()
        
        // Act
        let response = await apiServiceManager.getImageList()
        
        // Assert
        switch response {
        case .imageList(let publisher):
            let expectation = XCTestExpectation(description: "Image list publisher should complete successfully")
            
            publisher.sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Expected success but got failure")
                case .finished:
                    expectation.fulfill()
                }
            }, receiveValue: { value in
                XCTAssertEqual(value.count, 0, "Image list should be empty")
            })
            .store(in: &cancellables)
            
            await fulfillment(of: [expectation], timeout: 1.0)
            
        default:
            XCTFail("Expected imageList response")
        }
    }
    
    func testGetImageListFailure() async {
        // Arrange
        mockApiService.getImageListResult = Fail(error: AppNetworkError.failed)
            .eraseToAnyPublisher()
        
        // Act
        let response = await apiServiceManager.getImageList()
        
        // Assert
        switch response {
        case .imageList(let publisher):
            let expectation = XCTestExpectation(description: "Image list publisher should fail with network error")
            
            publisher.sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error.description, AppNetworkError.failed.description, "Expected network failure error")
                    expectation.fulfill()
                case .finished:
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)
            
            await fulfillment(of: [expectation], timeout: 1.0)
            
        default:
            XCTFail("Expected imageList response")
        }
    }
    
    func testDownloadImageSuccess() async {
        // Arrange
        let expectedData = Data([0x1, 0x2, 0x3])
        mockApiService.downloadImageResult = Just(expectedData)
            .setFailureType(to: AppNetworkError.self)
            .eraseToAnyPublisher()
        
        // Act
        let response = await apiServiceManager.downloadImage("https://example.com/image.png")
        
        // Assert
        switch response {
        case .downloadImage(let publisher):
            let expectation = XCTestExpectation(description: "Download image publisher should complete successfully")
            
            publisher.sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Expected success but got failure")
                case .finished:
                    expectation.fulfill()
                }
            }, receiveValue: { data in
                XCTAssertEqual(data, expectedData, "Downloaded data should match expected data")
            })
            .store(in: &cancellables)
            
            await fulfillment(of: [expectation], timeout: 1.0)
            
        default:
            XCTFail("Expected downloadImage response")
        }
    }
    
    func testDownloadImageFailure() async {
        // Arrange
        mockApiService.downloadImageResult = Fail(error: AppNetworkError.invalidRequest)
            .eraseToAnyPublisher()
        
        // Act
        let response = await apiServiceManager.downloadImage("https://example.com/image.png")
        
        // Assert
        switch response {
        case .downloadImage(let publisher):
            let expectation = XCTestExpectation(description: "Download image publisher should fail with network error")
            
            publisher.sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error.description, AppNetworkError.invalidRequest.description, "Expected network failure error")
                    expectation.fulfill()
                case .finished:
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)
            
            await fulfillment(of: [expectation], timeout: 1.0)
            
        default:
            XCTFail("Expected downloadImage response")
        }
    }
}
