//
//  ImageDetailView.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import SwiftUI
import SwiftData

struct ImageDetailView: View {
    
    private let photo: Photo
    
    init(_ photo: Photo) {
        self.photo = photo
    }
    
    var body: some View {
        VStack {
            Text(photo.title)
            Text("\(photo.albumId)")
            Text(photo.thumbnailUrl)
        }
    }
}

#Preview {
    ImageDetailView(.init(albumId: 1, id: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "", thumbnailUrl: "https://via.placeholder.com/150/92c952"))
}
