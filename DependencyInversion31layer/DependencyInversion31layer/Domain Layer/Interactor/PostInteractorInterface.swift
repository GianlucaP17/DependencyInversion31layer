//
//  InteractorInterface.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

///Interactor: contains business logic for each specific feature. It is also called Use Case
public protocol PostInteractorInterface {
    func getPosts() async throws -> [PostEntity]
}

