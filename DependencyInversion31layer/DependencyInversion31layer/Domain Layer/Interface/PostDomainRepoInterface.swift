//
//  PostDomainRepoInterface.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

///Domain Repo Interface: this interface/protocol is an abstraction of how the interactor gets data from data layer
public protocol PostDomainRepoInterface {
    func getPosts() async throws -> [PostEntity]
}
