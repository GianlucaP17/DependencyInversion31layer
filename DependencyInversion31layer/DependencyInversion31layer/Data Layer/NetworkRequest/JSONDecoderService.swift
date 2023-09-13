//
//  JSONDecoderService.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

//Define an interface for the decoder
protocol DataDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

//Create JSON decoder
class JSONDecoderService: DataDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
    
    /// > NetworkManager
}
