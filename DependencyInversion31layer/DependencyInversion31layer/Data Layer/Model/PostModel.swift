//
//  PostModel.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

public struct PostModel: Codable {
    
    public let userId: Int?
    public let id: Int?
    public let title: String?
    public let body: String
    
    
    // DOT: Data Object Transfer
    public func dotPostEntity() -> PostEntity {
        return PostEntity(userId: userId, id: id, title: title, body: body)
    }
}
