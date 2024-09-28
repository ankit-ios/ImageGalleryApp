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
    
    private var apiService: ApiService
    
    init(apiService: ApiService = .shared) {
        self.apiService = apiService
    }
    
    func getImageList() async -> IGResponse {
        .imageList(apiService.get(request: IGApi.imageList))
    }
    
    func getImageDetail() async -> IGResponse {
        .imageList(apiService.get(request: IGApi.imageDetail))
    }
}
