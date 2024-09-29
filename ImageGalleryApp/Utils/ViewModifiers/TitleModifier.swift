//
//  TitleModifier.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 29/09/24.
//

import SwiftUI

//MARK: - Title Modifiers

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(AppFont.title)
            .multilineTextAlignment(.center)
            .foregroundColor(AppColor.Text.secondary)
    }
}

struct LargeTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(AppFont.largetitle)
            .padding()
            .foregroundColor(AppColor.Text.primary)
    }
}
