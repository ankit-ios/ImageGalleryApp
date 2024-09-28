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
    
    func get<T>(url: String) -> AnyPublisher<T, AppNetworkError> {
        makeRequest(url: url, method: .get)
    }
}

private extension ApiService {
    
    func makeRequest<T: Decodable>(request: ApiRequest) -> AnyPublisher<T, AppNetworkError> {
        let urlRequest = request.buildURLRequest()
        return fetchFromNetwork(urlRequest)
    }
    
    func makeRequest<T>(url: String, method: HTTPMethod, body: Data? = nil) -> AnyPublisher<T, AppNetworkError> {
        guard let url = URL(string: url) else {
            return Fail(error: AppNetworkError.invalidRequest)
                .eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if let body = body {
            urlRequest.httpBody = body
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return fetchRawData(urlRequest)
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
    
    func fetchRawData<T>(_ urlRequest: URLRequest) -> AnyPublisher<T, AppNetworkError> {
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw AppNetworkError.invalidResponse
                }
                return output.data as! T
            }
            .mapError { AppNetworkError.unableToDecode($0) } // Map errors accordingly
            .eraseToAnyPublisher()
    }
}
