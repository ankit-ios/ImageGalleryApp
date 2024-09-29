//
//  ImageDetailView.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import SwiftUI
import SwiftData

//MARK: - ImageDetail View

struct ImageDetailView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @State var vm: ImageDetailViewModel
    
    init(_ photo: Photo) {
        self.vm = ImageDetailViewModel(ImageDetailViewItem(photo: photo))
    }
    
    var body: some View {
        ScrollView {
            getBody()
        }
        .fillMaxSize()
        .padding()
        .showBackButton()
        .navigationTitle(ScreenTitleConstant.imageDetail)
        .navigationBarTitleDisplayMode(.inline)
        .background(AppColor.Background.default)
    }
    
    ///Returing body based on LoadingState
    @ViewBuilder
    func getBody() -> some View {
        VStack {
            AsyncImageView(vm.detailViewItem.imageURL)
                .frame(width: Constants.cellHeight, height: Constants.cellHeight)
            photoDescriptionView()
            Spacer()
        }
        .padding(.top, SpacingConstant.spacing_4)
    }
    
    @ViewBuilder func photoDescriptionView() -> some View {
        VStack(spacing: SpacingConstant.spacing_10) {
            HStack {
                Text(TitleConstant.albumId + ": ")
                    .modifier(TitleModifier())
                Text("\(vm.detailViewItem.albumId)")
                    .modifier(TitleModifier())
            }
            HStack {
                Text(TitleConstant.photoId + ": ")
                    .modifier(TitleModifier())
                Text("\(vm.detailViewItem.id)")
                    .modifier(TitleModifier())
            }
            VStack {
                Text(TitleConstant.photoTitle)
                    .modifier(LargeTitleModifier())
                Text(vm.detailViewItem.title.capitalized)
                    .modifier(TitleModifier())
            }
        }
        .padding(.top, SpacingConstant.spacing_20)
    }
}

#Preview {
    ImageDetailView(.stub)
}
