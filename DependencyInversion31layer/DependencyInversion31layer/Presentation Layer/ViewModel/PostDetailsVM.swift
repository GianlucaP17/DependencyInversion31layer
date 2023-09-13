//
//  PostDetailsVM.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

public class PostDetailsVM: ObservableObject {
    
    @Published var post: PostEntity
    
    // So we can initialize it from the app layer
    public init(post: PostEntity) {
        self.post = post
    }
    
    /// > XCTest
}
