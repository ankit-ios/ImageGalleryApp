//
//  AppColor.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 28/09/24.
//

import SwiftUI

struct AppColor {
    struct Background {
        static let `default`: Color = .white
        static let primary: Color = .black.opacity(0.2)
        static let secondary: Color = .black.opacity(0.8)
    }
    
    struct Text {
        static let primary: Color = .white
        static let secondary: Color = .black.opacity(0.8)
        static let success: Color = .green
        static let failure: Color = .red
    }
}
