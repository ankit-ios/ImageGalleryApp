//
//  ImageDetailViewItem.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 29/09/24.
//

import Foundation

struct ImageDetailViewItem {
    
    let albumId: Int
    let title: String
    let imageURL: String

    init(photo: Photo) {
        self.albumId = photo.albumId
        self.title = photo.title
        self.imageURL = photo.url
    }
}