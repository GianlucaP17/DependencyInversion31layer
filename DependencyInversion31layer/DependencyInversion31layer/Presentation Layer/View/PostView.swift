//
//  PostView.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation
import SwiftUI
///PostView: represents a screen, contains UI components and navigation, shouldn’t contain any sort of logic
public struct PostView: View {
    
    var appDI: AppDIInterface
    @ObservedObject public var postVM: PostVM
    
    public init(appDI: AppDIInterface, postVM: PostVM) {
        self.appDI = appDI
        self.postVM = postVM
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("This is a demostration of how i usually build up my apps, loading data form an endPoint, decoding a JSON, shows data on a table.\nStarting with the architecture, a 3+1 layer, with Dependency Inversion, following the SOLID principles, managing error and separating each layer with the ability to make UITest and XCTest.")
                        .font(.system(size: 13))
                        .padding()
                    List {
                        ForEach(postVM.posts) { post in
                            NavigationLink(
                                destination: PostDetailsView(postDetailsVM: appDI.postDetailsDependencies(post: post)),
                                ///> postDetailsDependencies
                                label: {
                                    VStack(alignment: .leading) {
                                        Text(post.title ?? "")
                                            .font(.headline)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text(post.body)
                                            .font(.caption)
                                            .multilineTextAlignment(.leading)
                                            .padding(.vertical)
                                    }
                                })
                        }
                    }
                }
                ScreenAlert(text: postVM.showError?.localizedDescription ?? "Error loading data",
                            show: postVM.showError != nil)
            }
            .navigationBarTitle("Posts")
        }
        .onAppear {
            ///calling the method from its VM will get as the data to shows
            Task {
                try await self.postVM.getPosts()
            }
            ///> PostVM
        }
    }
    
    struct ScreenAlert: View {
        var text: String
        var show: Bool
        
        var body: some View {
            Text(text)
                .padding(20)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(color: Color.gray, radius: 5, x: 0, y: 5)
                .opacity(show ? 1 : 0)
                .padding()
        }
    }
    
    /// > Detail
}
