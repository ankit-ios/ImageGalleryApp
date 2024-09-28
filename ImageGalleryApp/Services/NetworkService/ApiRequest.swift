//
//  ApiRequest.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import Foundation

//MARK: - API Requests helpers
protocol ApiRequest {
    var baseURL: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var additionalHeader: [String: String] { get }
    var requestParameters: [String: Any]? { get }
    var body: [String: Any]? { get }
}

extension ApiRequest {
    var baseURL: String { AppConstants.API.baseURL() }
    var method: HTTPMethod { .get }
    var additionalHeader: [String: String] { [:] }
    var requestParameters: [String: Any]? { nil }
    var body: [String: Any]? { nil }
}

extension ApiRequest {
    func buildURLRequest() -> URLRequest {
        let urlString = baseURL + endpoint
        guard var url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        
        //query items
        if let queryItems = queryItems {
            url.append(queryItems: queryItems)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        //adding addition header e.g. Authorization token, Content-Type
        request.allHTTPHeaderFields = additionalHeader
        
        //adding body
        if method == .post, let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
                
        return request
    }
    
    private var queryItems: [URLQueryItem]? {
        guard let params = requestParameters else { return nil }
        return params.map { URLQueryItem(name: $0.key, value: String(describing: $0.value )) }
    }
}
