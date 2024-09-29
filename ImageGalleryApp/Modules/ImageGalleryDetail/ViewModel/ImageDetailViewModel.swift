//
//  ImageDetailViewModel.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 29/09/24.
//

import Combine

final class ImageDetailViewModel: ObservableObject {
    
    @Published var detailViewItem: ImageDetailViewItem
    
    init(_ detailViewItem: ImageDetailViewItem) {
        self.detailViewItem = detailViewItem
    }
}
