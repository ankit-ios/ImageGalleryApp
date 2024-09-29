//
//  ViewExtensions.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import SwiftUI

//MARK: - View extensions

public extension View {

    func fillMaxSize(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
}

public extension View {
    
    ///utility method for showing backbutton
    func showBackButton() -> some View {
        self.modifier(BackButtonModifier())
    }
}


//MARK: - Image extensions

extension Image {
    
    ///Converting data to Image
    static func image(for data: Data) -> Image? {
        guard let uiimage = UIImage(data: data) else { return nil }
        return Image(uiImage: uiimage)
    }
}
