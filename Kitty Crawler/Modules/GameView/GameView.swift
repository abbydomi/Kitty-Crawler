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
    @ObservedObject var viewModel = GameViewModel()
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: Constants.spacing),
        count: 5
    )
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
                Rectangle()
                    .foregroundStyle(Color.blue)
                    .aspectRatio(1, contentMode: .fit)
                LazyVGrid(columns: columns, spacing: Constants.spacing) {
                    ForEach(viewModel.tiles, id: \.self) { tile in
                        ZStack {
                            Circle()
                                .foregroundStyle(Color.cyan)
                                .padding()
                            if tile.type != .empty {
                                Image(tile.image)
                                    .resizable()
                                    .scaledToFit()
                                    .accessibilityLabel("\(tile.type)")
                            }
                            VStack {
                                Text("\(tile.type)")
                                Text("\(tile.power)")
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
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
                    Text("Inventory")
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

// MARK: - Preview
#Preview {
    GameView()
}
