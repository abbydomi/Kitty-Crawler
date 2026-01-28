//
//  ItemView.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 28/1/26.
//

import SwiftUI

struct ItemView: View {
    let item: Item?
    let action: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.blue)
            if let item {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .accessibilityLabel("\(item.type)")
                if item.power != 0 {
                    Text("\(item.power)")
                        .modifier(TextUIModifiers())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .padding(.horizontal, 4)
                }
            }
        }
        .accessibilityAddTraits(.isButton)
        .aspectRatio(1, contentMode: .fit)
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    ItemView(item: .init(power: 3, type: .attack)) {
        // interact
    }
    .aspectRatio(contentMode: .fit)
    .frame(maxWidth: 64)
}
