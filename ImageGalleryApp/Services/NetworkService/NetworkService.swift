//
//  NetworkService.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import Combine

enum IGResponse {
    case imageList(AnyPublisher<ImageList, AppNetworkError>)
    case imageDetail(AnyPublisher<ImageDetail, AppNetworkError>)
}

protocol NetworkService {
    func getImageList() async -> IGResponse
    func getImageDetail() async -> IGResponse
}
