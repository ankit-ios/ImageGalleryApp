//
//  ApiServiceManager.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import Combine
import Foundation

//MARK: - ApiServiceManager

final class ApiServiceManager: NetworkService {
    
    private var apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService.shared) {
        self.apiService = apiService
    }
    
    func getImageList() async -> IGResponse {
        .imageList(apiService.get(request: IGApi.imageList))
    }
    
    func downloadImage(_ url: String) async -> IGResponse {
        .downloadImage(apiService.get(url: url))
    }
}
