//
//  ImageDetailView.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import SwiftUI
import SwiftData

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
            Text("\(vm.detailViewItem.albumId)")
                .modifier(LargeTitleModifier())
            Text(vm.detailViewItem.title)
                .modifier(TitleModifier())
            Spacer()
        }
        .padding(.top, SpacingConstant.spacing_4)
    }
}

#Preview {
    ImageDetailView(.init(albumId: 1, id: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "", thumbnailUrl: "https://via.placeholder.com/150/92c952"))
}
