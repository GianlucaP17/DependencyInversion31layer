//
//  DataRepo.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

///DataRepo that implements this abstraction, so that data and domain are loosely coupled.
///here we have a list or Data source we can access to, so the external ccan call getPost and we decide what DataSource to use.
public class PostDataRepo: PostDomainRepoInterface {
    
    ///we get every DataSource we have
    let postRemoteDataSource: PostRemoteDataSourceInterface
    let postLocalDataSource: PostLocalDataSourceInterface?
    let coder: JSONDecoder
    
    public init(postRemoteDataSource: PostRemoteDataSourceInterface,
                postLocalDataSource: PostLocalDataSourceInterface? = nil,
                coder: JSONDecoder = JSONDecoder()) {
        
        self.postRemoteDataSource = postRemoteDataSource
        self.postLocalDataSource = postLocalDataSource
        
        self.coder = coder
    }
    
    ///create a method to get the desired data.
    public func getPosts() async throws -> [PostEntity] {
        let postModels = try await postRemoteDataSource.getPosts()
        return postModels.map { $0.dotPostEntity() }
    }

    
    /// > PostRemoteDataSource
}
