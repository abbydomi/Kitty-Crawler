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
    let columns = Array(
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
                Text("score")
            }
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
                            Image(tile.image)
                                .resizable()
                                .scaledToFit()
                                .accessibilityLabel("\(tile.type)")
                            VStack {
                                Text("(\(tile.position.x),\(tile.position.y))")
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
            HStack {
                Text("Health")
                Spacer()
                Text("Level")
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
