//
//  ImageListViewModel.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import Combine
import Foundation
import UIKit

protocol ImageListViewModelInput {
    func fetchImageList() async
}

final class ImageListViewModel: ObservableObject, ImageListViewModelInput {
    @Published private(set) var photos: ImageList = []
    @Published private(set) var errorMessage: String?
    @Published private(set) var loadingState: LoadingState = .idle
    
    private var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkService
    
    init(_ networkService: NetworkService) {
        self.networkService = networkService
    }
    
    @MainActor
    func fetchImageList() async {
        self.loadingState = .loading
        let result = await networkService.getImageList()
        if case let .imageList(imageList) = result {
            imageList
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.description
                        self?.loadingState = .error
                    case .finished:
                        self?.loadingState = .loaded
                    }
                }, receiveValue: { [weak self] photos in
                    self?.photos = photos
                })
                .store(in: &cancellables)
        }
    }
    
    
}
