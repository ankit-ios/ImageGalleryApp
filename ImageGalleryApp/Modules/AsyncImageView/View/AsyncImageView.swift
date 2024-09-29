//
//  AsyncImageView.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import SwiftUI

struct AsyncImageView: View {
    
    @StateObject private var vm: AsyncImageViewModel
    private let imageUrl: String
    
    init(_ imageUrl: String) {
        self.imageUrl = imageUrl
        self._vm = StateObject(wrappedValue: AsyncImageViewModel(imageUrl: imageUrl))
    }
    
    var body: some View {
        VStack {
            if let image = vm.downloadedImage {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                placeholderView()
            }
        }
        .cornerRadius(SpacingConstant.spacing_10)
        .shadow(color: .gray, radius: 5, x: 0, y: 5)
        .transition(.opacity)
    }
    
    func placeholderView() -> some View {
        Rectangle()
            .foregroundColor(.gray)
            .overlay(
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            )
            .task {
                await vm.downloadImage()
            }
    }
}
