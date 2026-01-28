//
//  GameView.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 17/10/24.
//

import SwiftUI

struct GameView: View {
    // MARK: - Constants
    enum Constants {
        static let spacing: CGFloat = 10
    }
    // MARK: - Properties
    @StateObject private var viewModel = GameViewModel()
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: Constants.spacing),
        count: 5
    )
    @Namespace private var playerNamespace
    // MARK: - View
    var body: some View {
        VStack {
            // MARK: Top UI
            Spacer()
            HStack {
                Spacer()
                Text(String(format: NSLocalizedString("ScoreTag", bundle: .main, comment: ""), viewModel.score))
                    .modifier(TextUIModifiers())
            }
            .padding(.horizontal)
            // MARK: Board
            ZStack {
                boardBackground()
                LazyVGrid(columns: columns, spacing: Constants.spacing) {
                    ForEach(viewModel.tiles) { tile in
                        TileView(tile: tile, namespace: playerNamespace) {
                            viewModel.handleTileTap(tile: tile)
                        }
                    }
                }
                .padding(Constants.spacing)
            }
            // MARK: Bottom UI
            VStack {
                HStack {
                    HealthUIView(viewModel: viewModel)
                    Spacer()
                    Text(String(format: NSLocalizedString("LevelTag", bundle: .main, comment: ""), viewModel.level))
                        .modifier(TextUIModifiers())
                }
                HStack {
                    inventory
                    Spacer()
                    Text("Backpack")
                }
                HStack {
                    Text("Money")
                    Spacer()
                    Text("XP")
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .background {
            VStack {
                Color.blue
                Color.cyan
            }
            .ignoresSafeArea()
        }
    }
}
// MARK: - Subviews
private extension GameView {
    func boardBackground() -> some View {
        Rectangle()
            .foregroundStyle(Color.blue)
            .aspectRatio(1, contentMode: .fit)
    }

    var inventory: some View {
        HStack {
            TileView(power: viewModel.attack, itemType: .attack, namespace: playerNamespace) {
                viewModel.handleItemTap()
            }
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 64)
            TileView(power: viewModel.defense, itemType: .defense, namespace: playerNamespace) {
                viewModel.handleItemTap()
            }
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 64)
        }
    }
}

// MARK: - Preview
#Preview {
    GameView()
}
