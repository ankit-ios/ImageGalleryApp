//
//  ImageList.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import Foundation

typealias ImageList = [Photo]

struct Photo: Decodable, Identifiable, Hashable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

extension Photo {
    
    static let stub: Photo = .init(albumId: 1, id: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "", thumbnailUrl: "https://via.placeholder.com/150/92c952")
}
