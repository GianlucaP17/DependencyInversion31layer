//
//  PostLocalDataSourceInterface.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

///We are not doing the local data source
public protocol PostLocalDataSourceInterface {
    func getCachedPosts() async throws -> [PostEntity]
}
