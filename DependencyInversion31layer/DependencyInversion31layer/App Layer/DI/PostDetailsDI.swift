//
//  PostDetailsDI.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

class PostDetailsDI {
    let appEnvironment: AppEnvironment
    
    init(appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
    }
    ///as wrote before, we need to add 9 file to make a new feature, but this depends... i can have even one dependency.
    func postDetailsDependencies(post: PostEntity) -> PostDetailsVM {
        // Presentation
        let postDetailsVM = PostDetailsVM(post: post)
        /// > PostDetailsView
        return postDetailsVM
    }
    
    /// > PostView
}
