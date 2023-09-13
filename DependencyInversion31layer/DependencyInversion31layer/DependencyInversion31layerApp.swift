//
//  DependencyInversion31layerApp.swift
//  DependencyInversion31layer
//
//  Created by Gianluca Posca on 11/09/23.
//

import SwiftUI

@main
struct DependencyInversion31layerApp: App {
    var body: some Scene {
        WindowGroup {
            ///everything start from here with an injection of the requred viewModel and their dependency Interface.
            PostView(appDI: AppDI.shared, postVM: AppDI.shared.postDependencies())
        }
    }
    /// > AppEnvironment
}
