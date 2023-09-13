//
//  PostRemoteDataSource.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

///we create a DataSource to make the desire work to get the data.
public class PostRemoteDataSource: PostRemoteDataSourceInterface {
    
    let urlString: String
    let coder: JSONDecoder
    
    required public init(urlString: String, coder: JSONDecoder = JSONDecoder()) {
        self.urlString = urlString
        self.coder = coder
    }
    
    public func getPosts() async throws -> [PostModel] {
        let networkService = URLSessionService()
        let dataDecoder = JSONDecoderService()
        let postManager = NetworkManager<PostModel>(networkService: networkService, dataDecoder: dataDecoder)
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let postModels = try await postManager.getPosts(url: url)
            return postModels
        } catch {
            throw mapNetworkError(error)
        }
    }
    
    private func mapNetworkError(_ error: Error) -> NetworkError {
        switch error {
        case NetworkError.invalidURL:
            return .invalidURL
        case NetworkError.noData:
            return .noData
        case NetworkError.decodingError:
            return .decodingError
        case NetworkError.requestFailed(let underlyingError):
            return .requestFailed(underlyingError)
        case NetworkError.badRequest:
            return .badRequest
        case NetworkError.serverError:
            return .serverError
        default:
            return .unknownError
        }
    }
    
    /// > UrlSessionService
}


