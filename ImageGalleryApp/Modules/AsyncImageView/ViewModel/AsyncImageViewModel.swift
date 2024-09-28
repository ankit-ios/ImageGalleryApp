//
//  AsyncImageViewModel.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import SwiftUI
import Combine

class AsyncImageViewModel: ObservableObject {
    
    @Published var downloadedImage: Image?
    private let imageUrl: String
    private let imageDownloadService: ImageDownloadService
    private var cancellables = Set<AnyCancellable>()
    
    init(imageUrl: String, imageDownloadService: ImageDownloadService = ImageDownloadManager()) {
        self.imageUrl = imageUrl
        self.imageDownloadService = imageDownloadService
    }
    
    func downloadImage() async {
        await imageDownloadService.loadImage(from: imageUrl)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.description)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] imageData in
                withAnimation {
                    self?.downloadedImage = Image.image(for: imageData)
                }
            })
            .store(in: &cancellables)
    }
}
