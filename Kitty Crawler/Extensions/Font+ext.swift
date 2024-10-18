//
//  Font+ext.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 18/10/24.
//

import SwiftUI

extension Font {
    enum Nunito: String {
        case regular = "Nunito-Regular"
        case extraLight = "Nunito-ExtraLight"
        case light = "Nunito-Light"
        case medium = "Nunito-Medium"
        case semiBold = "Nunito-SemiBold"
        case bold = "Nunito-Bold"
        case extraBold = "Nunito-ExtraBold"
        case black = "Nunito-Black"
    }

    static func nunito(_ family: Nunito = .regular, size: CGFloat) -> Font {
        .custom(family.rawValue, size: size)
    }
}
