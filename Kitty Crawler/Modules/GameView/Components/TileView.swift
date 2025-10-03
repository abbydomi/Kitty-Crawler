//
//  TileView.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 3/10/25.
//

import SwiftUI

struct TileView: View {
    let tile: Tile

    var body: some View {
        ZStack {
            tileBackground()
            if tile.type != .empty {
                tileIcon(tile: tile)
            }
            #if DEBUG
            VStack {
                if tile.type != .empty {
                    Text("\(tile.type)")
                    Text("\(tile.power)")
                }
            }
            #endif
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

private extension TileView {
    func tileBackground() -> some View {
        Circle()
            .foregroundStyle(Color.cyan)
            .padding()
    }

    func tileIcon(tile: Tile) -> some View {
        Image(tile.image)
            .resizable()
            .scaledToFit()
            .accessibilityLabel("\(tile.type)")
    }
}
