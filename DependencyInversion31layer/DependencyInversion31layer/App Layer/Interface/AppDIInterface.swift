//
//  AppDIInterface.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import Foundation

public protocol AppDIInterface {
    func postDependencies() -> PostVM
    func postDetailsDependencies(post: PostEntity) -> PostDetailsVM
}
