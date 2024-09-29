//
//  ImageDetailViewModelTests.swift
//  ImageGalleryAppTests
//
//  Created by Ankit Sharma on 29/09/24.
//

import XCTest
import Combine
@testable import ImageGalleryApp

final class ImageDetailViewModelTests: XCTestCase {
    
    var sut: ImageDetailViewModel!
    var imageDetailViewItem: ImageDetailViewItem!
    
    override func setUp() {
        super.setUp()
        
        // Arrange
        let photo = Photo.stub
        imageDetailViewItem = ImageDetailViewItem(photo: photo)
        
        // Act
        sut = ImageDetailViewModel(imageDetailViewItem)
    }
    
    override func tearDown() {
        sut = nil
        imageDetailViewItem = nil
        super.tearDown()
    }
    
    func testViewModelInitialization() {
        // Assert
        XCTAssertEqual(sut.detailViewItem.id, imageDetailViewItem.id, "Expected ViewModel to be initialized with the correct id.")
        XCTAssertEqual(sut.detailViewItem.albumId, imageDetailViewItem.albumId, "Expected ViewModel to be initialized with the correct albumId.")
        XCTAssertEqual(sut.detailViewItem.title, imageDetailViewItem.title, "Expected ViewModel to be initialized with the correct title.")
        XCTAssertEqual(sut.detailViewItem.imageURL, imageDetailViewItem.imageURL, "Expected ViewModel to be initialized with the correct imageURL.")
    }
    
    func testDetailViewItemUpdate() {
        // Arrange
        let newPhoto = Photo(albumId: 1, id: 2, title: "reprehenderit est deserunt velit ipsam", url: "https://example.com/new_image.jpg", thumbnailUrl: "https://via.placeholder.com/150/771796")
        let newDetailViewItem = ImageDetailViewItem(photo: newPhoto)
        
        // Act
        sut.detailViewItem = newDetailViewItem
        
        // Assert
        XCTAssertEqual(sut.detailViewItem.id, newDetailViewItem.id, "Expected ViewModel to update id.")
        XCTAssertEqual(sut.detailViewItem.albumId, newDetailViewItem.albumId, "Expected ViewModel to update albumId.")
        XCTAssertEqual(sut.detailViewItem.title, newDetailViewItem.title, "Expected ViewModel to update title.")
        XCTAssertEqual(sut.detailViewItem.imageURL, newDetailViewItem.imageURL, "Expected ViewModel to update imageURL.")
    }
}
