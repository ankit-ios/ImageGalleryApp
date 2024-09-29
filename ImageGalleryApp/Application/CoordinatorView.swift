//
//  CoordinatorView.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import SwiftUI

///This is entry point View for App, and `CoordinatorView` manages all type of routing between screens
struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .imageList)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.build(page: page)
                }
        }
        .environmentObject(coordinator)
    }
}
