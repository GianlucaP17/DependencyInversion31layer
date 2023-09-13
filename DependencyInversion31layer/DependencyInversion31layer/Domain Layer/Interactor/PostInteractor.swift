//
//  PostInteractor.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

public class PostInteractor: PostInteractorInterface {
    let postDomainRepo: PostDomainRepoInterface
    
    ///PostInteractor uses an injected postDomainRepo object which conforms to PostDomainRepoInterface to get data.
    public init(postDomainRepo: PostDomainRepoInterface) {
        self.postDomainRepo = postDomainRepo
    }
    
    ///interactor/UseCase
    ///getPosts() method doesn’t contain actual business logic, just calling another method for the sake of simplicity. But this is where you apply your business logic. For example you can check if a post contains racist words to ban the post — or feature it if you are racist. Or you can check if you have added any of these posts to your favorites and apply a star to it.
    public func getPosts() async throws -> [PostEntity] {
        let postDomainModelArray = try await postDomainRepo.getPosts()
        return postDomainModelArray
    }

    
    /// > DataRepo
}
