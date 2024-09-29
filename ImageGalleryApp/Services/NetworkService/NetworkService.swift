//
//  NetworkService.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import Foundation
import Combine

enum IGResponse {
    case imageList(AnyPublisher<ImageList, AppNetworkError>)
    case downloadImage(AnyPublisher<Data, AppNetworkError>)
}

protocol NetworkService {
    func getImageList() async -> IGResponse
    func downloadImage(_ url: String) async -> IGResponse
}

protocol ApiServiceProtocol {
    func get<T: Decodable>(request: ApiRequest) -> AnyPublisher<T, AppNetworkError>
    func get<T>(url: String) -> AnyPublisher<T, AppNetworkError>
}
