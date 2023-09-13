//
//  PostVM.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation
///PostVM: Post View Model is responsible for converting the Entity in such a way that data is easily managed and presented. It handles all of the view’s display logic.
public class PostVM: ObservableObject {
    
    @Published var posts: [PostEntity] = []
    @Published var showError : NetworkError? = nil
    
    private var postInteractor: PostInteractorInterface
    
    ///postInteractor is injected to the the PostVM in the init method as an abstraction, so we can mock it in unit testing.
    public init(postInteractor: PostInteractorInterface) {
        self.postInteractor = postInteractor
    }
    
    func getPosts() async throws -> [PostEntity] {
        do {
            let postArray = try await postInteractor.getPosts()
            self.posts = postArray
            self.showError = nil
            return postArray
        } catch {
            if let error = error as? NetworkError {
                self.showError = error
            }
            return []
        }
    }

}

///PostVM has a reference to PostInteractor in the domain layer to get the Entity.
/// > PostInteractor
