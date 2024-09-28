//
//  ImageDownloadService.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import Foundation
import Combine

protocol ImageDownloadService {
    var imageCachingService: ImageCachingService { get }
    var networkService: NetworkService { get }
    
    func loadImage(from urlString: String) async -> AnyPublisher<Data, AppNetworkError>
}

final class ImageDownloadManager: ImageDownloadService {
    
    var imageCachingService: ImageCachingService
    var networkService: NetworkService
    private var cancellables = Set<AnyCancellable>()
    
    init(imageCachingService: ImageCachingService = ImageCachingManager(),
         networkService: NetworkService = ApiServiceManager()) {
        self.imageCachingService = imageCachingService
        self.networkService = networkService
    }
    
    func loadImage(from urlString: String) async -> AnyPublisher<Data, AppNetworkError> {
        
        // Check if the image is cached
        let imageObj = imageCachingService.fetchCachedImage(forKey: urlString)
        if let imageData = imageObj as? Data {
            // Return the cached image data as a publisher
            return Just(imageData)
                .setFailureType(to: AppNetworkError.self)
                .eraseToAnyPublisher()
        }
        
        // If not cached, download the image
        let downloadedImage = await networkService.downloadImage(urlString)
        if case let .downloadImage(imagePublisher) = downloadedImage {
            return imagePublisher
                .tryMap { [weak self] data -> Data in
                    self?.imageCachingService.cacheImage(data as NSObject, forKey: urlString)
                    return data
                }
                .mapError { error in
                    // Convert any error to AppNetworkError
                    error as? AppNetworkError ?? AppNetworkError.noData
                }
                .eraseToAnyPublisher()
        }
        return Fail(error: AppNetworkError.invalidResponse)
            .eraseToAnyPublisher()
    }
}
