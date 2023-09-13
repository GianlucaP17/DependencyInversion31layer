//
//  PostDetailsView.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import SwiftUI

struct PostDetailsView: View {
    
    @ObservedObject public var postDetailsVM: PostDetailsVM
    
    public init(postDetailsVM: PostDetailsVM) {
        self.postDetailsVM = postDetailsVM
        /// > PostDetailsVM
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(postDetailsVM.post.title ?? "")
                .font(.headline)
                .multilineTextAlignment(.leading)
            
            Text(postDetailsVM.post.body )
                .font(.caption)
                .multilineTextAlignment(.leading)
                .padding(.vertical)
        }
    }
}
