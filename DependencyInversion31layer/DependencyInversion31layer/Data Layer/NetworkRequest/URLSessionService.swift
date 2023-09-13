//
//  URLSessionService.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

/// Define a protocol for UrlSession
protocol NetworkService {
    func fetchData(from url: URL) async throws -> Data
}

/// Create method for fetching data
class URLSessionService: NetworkService {
    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badRequest
        }
        
        switch httpResponse.statusCode {
        case 200:
            return data
        case 400:
            throw NetworkError.badRequest
        case 500:
            throw NetworkError.serverError
        default:
            throw NetworkError.unknownError
        }
    }
    
    /// > JSONDecoder
}
