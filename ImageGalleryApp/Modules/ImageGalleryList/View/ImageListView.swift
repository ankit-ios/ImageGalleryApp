//
//  ImageListView.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import SwiftUI
import Combine

struct ImageListView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject var vm: ImageListViewModel
    
    init(vm: ImageListViewModel = ImageListViewModel(ApiServiceManager())) {
        self._vm = StateObject(wrappedValue: vm)
    }
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            getBody(for: vm.loadingState)
        }
        .padding()
        .fillMaxSize()
        .navigationTitle(ScreenTitleConstant.imageList)
        .navigationBarTitleDisplayMode(.inline)
        .background(AppColor.Background.default)
        .onAppear {
            if vm.loadingState == .idle {
                Task { await vm.fetchImageList() }
            }
        }
    }
    
    ///Returing body based on LoadingState
    @ViewBuilder
    func getBody(for loadingState: LoadingState) -> some View {
        switch loadingState {
        case .idle: EmptyView()
        case .loading:
            ProgressView(TitleConstant.loadingDetails)
                .fillMaxSize()
                .foregroundColor(AppColor.Text.secondary)
        case .loaded:
            imageListView()
        case .error:
            ContentUnavailableView {
                Label(TitleConstant.noDetailsFound, systemImage: ImageConstant.unavailable)
            } description: {
                Text(vm.errorMessage ?? "")
            }
        }
    }
    
    @ViewBuilder func imageListView() -> some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let cellWidth = width/2 - SpacingConstant.spacing_20
            ScrollView {
                LazyVGrid(columns: columns, spacing: SpacingConstant.spacing_20) {
                    ForEach(vm.photos) { photo in
                        photoCellView(photo, width: cellWidth)
                    }
                }
            }
        }
    }
    
    
    @ViewBuilder func photoCellView(_ photo: Photo, width: CGFloat) -> some View {
        Button {
            coordinator.push(page: .imageDetail(photo))
        } label: {
            VStack {
                AsyncImageView(photo.thumbnailUrl)
                    .frame(width: width, height: width)
            }
        }
    }
}

#Preview {
    ImageListView()
}
