//
//  GameViewModel.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 17/10/24.
//

import Combine
import Foundation

class GameViewModel: ObservableObject {
    @Published var tiles: [Tile] = []

    init() {
        createBoard()
    }
}

private extension GameViewModel {
    func createBoard() {
        for coordinateX in 1...5 {
            for coordinateY in 1...5 {
                var newTile = Tile(power: 0, position: Position(x: coordinateX, y: coordinateY))
                newTile.power = coordinateX * coordinateY
                tiles.append(newTile)
            }
        }
    }
}
