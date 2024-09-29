//
//  BackButtonModifier.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 29/09/24.
//

import SwiftUI

struct BackButtonModifier: ViewModifier {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton()
                }
            }
    }
    
    @ViewBuilder private func backButton() -> some View {
        Button(action: { coordinator.pop() }) {
            Image(systemName: ImageConstant.back)
                .font(AppFont.title)
                .foregroundColor(AppColor.Text.secondary)
        }
    }
}
