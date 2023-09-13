//
//  PostDI.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

class PostDI {
    
    let appEnvironment: AppEnvironment
    
    init(appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
    }
    
    ///every feature has its own dependency to rely on divided in 3 layers.
    func postDependencies() -> PostVM {
        
        // Data Layer
        let baseURL = appEnvironment.baseURL
        
        // Data Source
        let postRemoteDataSource = PostRemoteDataSource(urlString: baseURL)
        
        // Data Repo
        let postDataRepo = PostDataRepo(postRemoteDataSource: postRemoteDataSource)
        
        // Domain Layer
        let postInteractor = PostInteractor(postDomainRepo: postDataRepo)
        
        // Presentation
        let postVM = PostVM(postInteractor: postInteractor)
        
        return postVM
    }
    
    /// > PostDetailDI
}
