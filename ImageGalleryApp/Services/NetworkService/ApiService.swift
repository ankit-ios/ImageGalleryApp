//
//  ApiService.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import Foundation
import Combine

//MARK: - Api Service we can laverage for network calling to fetch data from server

final class ApiService {
    
    static let shared = ApiService()
    private init() {}
    
    func get<T: Decodable>(request: ApiRequest) -> AnyPublisher<T, AppNetworkError> {
        makeRequest(request: request)
    }
}

private extension ApiService {
    
    func makeRequest<T: Decodable>(request: ApiRequest) -> AnyPublisher<T, AppNetworkError> {
        guard let url = URL(string: request.endpoint) else {
            return Fail(error: AppNetworkError.invalidRequest)
                .eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        return fetchFromNetwork(urlRequest)
    }
    
    func fetchFromNetwork<T: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<T, AppNetworkError> {
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw AppNetworkError.invalidResponse
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { AppNetworkError.unableToDecode($0) }
            .eraseToAnyPublisher()
    }
}
