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
        ZStack {
            Rectangle()
                .foregroundStyle(Color.blue)
                .aspectRatio(1, contentMode: .fit) // Ensure the grid remai
            LazyVGrid(columns: columns, spacing: Constants.spacing) {
                ForEach(viewModel.tiles, id: \.self) { tile in
                    ZStack {
                        Rectangle()
                            .aspectRatio(1, contentMode: .fit)
                            .foregroundStyle(Color.orange)
                        Text(String(tile.power))
                    }
                }
            }
            .padding(Constants.spacing)
        }
    }
}

// MARK: - Preview
#Preview {
    GameView()
}
