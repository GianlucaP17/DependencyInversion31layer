//
//  PostEntity.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

///Entity: a model contains data for the interactor. Data model that suits the business logic.
public struct PostEntity: Identifiable {
    
    public let userId: Int?
    public let id: Int?
    public let title: String?
    public let body: String
    
    public init(userId: Int?, id: Int?, title: String?, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}
