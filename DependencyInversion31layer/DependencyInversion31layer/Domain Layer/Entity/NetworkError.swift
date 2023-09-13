//
//  NetworkError.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case requestFailed(Error)
    case badRequest
    case serverError
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The provided URL is not valid."
        case .noData:
            return "No data is available for this request."
        case .decodingError:
            return "An error occurred while trying to process the received data."
        case .requestFailed:
            return "The request could not be completed due to an error."
        case .badRequest:
            return "The request is invalid or malformed."
        case .serverError:
            return "There was an issue on the server's side."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
    
}
