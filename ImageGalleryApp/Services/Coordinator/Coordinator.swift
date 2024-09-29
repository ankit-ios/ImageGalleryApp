//
//  Coordinator.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import SwiftUI
import Combine

///`Coordinator` is passed in enviornment object,
///So all views can access it and make it navigation easier
final class Coordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    
    func push(page: AppPages) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
        case .imageList: ImageListView()
        case .imageDetail(let photo): ImageDetailView(photo)
        }
    }
}
