//
//  TileView.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 3/10/25.
//

import SwiftUI

struct TileView: View {
    let tile: Tile
    let namespace: Namespace.ID
    let action: () -> Void
    private let isItem: Bool
    private let backgroundColor: Color

    init(tile: Tile, namespace: Namespace.ID, action: @escaping () -> Void) {
        self.tile = tile
        self.namespace = namespace
        self.action = action
        self.backgroundColor = .blue
        self.isItem = false
    }

    init(power: Int, itemType: TileType, namespace: Namespace.ID, action: @escaping () -> Void) {
        self.tile = .init(power: power, position: .init(x: -9, y: -9), type: itemType)
        self.namespace = namespace
        self.action = action
        self.backgroundColor = .blue
        self.isItem = true
    }

    var body: some View {
        ZStack {
            tileBackground()
            if tile.type != .empty {
                tileIcon(tile: tile)
            }
            if tile.power != 0 {
                Text("\(tile.power)")
                    .modifier(TextUIModifiers())
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }
        .accessibilityAddTraits(.isButton)
        .aspectRatio(1, contentMode: .fit)
        .matchedGeometryEffect(
            id: tile.type == .player ? "player" : tile.id,
            in: namespace,
            isSource: tile.type == .player
        )
        .onTapGesture {
            action()
        }
        .overlay {
            VStack {
                if tile.position.x != -9 {
                    Text("(\(tile.position.x), \(tile.position.y))")
                        .background {
                            Color.white
                                .opacity(0.75)
                        }
                    Text("\(tile.type)")
                }
            }
            .offset(y: 24)
        }
    }
}

private extension TileView {
    @ViewBuilder
    func tileBackground() -> some View {
        if isItem {
            RoundedRectangle(cornerRadius: 4)
                .fill(backgroundColor)
        } else {
            Circle()
                .foregroundStyle(backgroundColor)
                .padding()
        }
    }

    func tileIcon(tile: Tile) -> some View {
        Image(tile.image)
            .resizable()
            .scaledToFit()
            .accessibilityLabel("\(tile.type)")
    }
}
