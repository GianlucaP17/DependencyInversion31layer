//
//  AppDI.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

class AppDI: AppDIInterface {
    ///here it's created a singleton to always have access to the features dependencies.
    static let shared = AppDI(appEnvironment: AppEnvironment())
    
    let appEnvironment: AppEnvironment
    
    init(appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
    }
    
    ///every feature has its method.
    func postDependencies() -> PostVM {
        let postDI: PostDI = PostDI(appEnvironment: appEnvironment)
        let postVM: PostVM = postDI.postDependencies()
        return postVM
    }
    
    ///every new feature has got its method, it can be boilerplate (need 9 files for new feature)
    ///if it is a simple app, but as soon as it growths it will me more managable.
    func postDetailsDependencies(post: PostEntity) -> PostDetailsVM {
        let postDetailsDI: PostDetailsDI = PostDetailsDI(appEnvironment: appEnvironment)
        let postDetailsVM: PostDetailsVM = postDetailsDI.postDetailsDependencies(post: post)
        ///> PostDetailsDI
        return postDetailsVM
    }
    
    ///> PostDI
}
