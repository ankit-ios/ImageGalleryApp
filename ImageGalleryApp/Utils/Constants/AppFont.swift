//
//  AppFont.swift
//  ImageGalleryApp
//
//  Created by Ankit Sharma on 29/09/24.
//

import UIKit
import SwiftUI

struct AppFont {
    
    enum HelveticaNeue: String {
        case bold = "HelveticaNeue-Bold"
    }
    
    static let largetitle: Font = AppFont.font(.bold, with: 32)
    static let title: Font = AppFont.font(.bold, with: 22)
}

extension AppFont {
    
    static func font(_ name: HelveticaNeue, with size: CGFloat) -> Font {
        return Font.custom(name.rawValue, size: size)
    }
}
