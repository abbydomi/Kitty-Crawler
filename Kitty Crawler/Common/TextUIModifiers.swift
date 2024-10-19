//
//  TextUIModifiers.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 19/10/24.
//

import SwiftUI

struct TextUIModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .font(.nunito(.black, size: 24))
            .shadow(radius: 1)
    }
}
