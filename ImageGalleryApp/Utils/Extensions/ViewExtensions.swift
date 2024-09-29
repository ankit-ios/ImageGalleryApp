//
//  ViewExtensions.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import SwiftUI

public extension View {

    func fillMaxSize(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }

    func fillMaxWidth(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }

    func fillMaxHeight(alignment: Alignment = .center) -> some View {
        frame(maxHeight: .infinity, alignment: alignment)
    }
}

public extension View {
    
    func showBackButton() -> some View {
        self.modifier(BackButtonModifier())
    }
}

extension Image {
    
    static func image(for data: Data) -> Image? {
        guard let uiimage = UIImage(data: data) else { return nil }
        return Image(uiImage: uiimage)
    }
}
