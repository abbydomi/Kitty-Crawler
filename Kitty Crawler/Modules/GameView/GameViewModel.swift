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
        let coordinateXExit = Int.random(in: 1...5)
        for coordinateX in 1...5 {
            for coordinateY in 1...5 {
                var newTile = Tile(
                    power: 0,
                    position: Position(x: coordinateX, y: coordinateY),
                    type: .empty
                )
                // Spawn tile
                if coordinateX == 3 && coordinateY == 5 {
                    newTile.type = .player
                }
                // Exit tile
                if coordinateX == coordinateXExit && coordinateY == 1 {
                    newTile.type = .exit
                }
                tiles.append(newTile)
            }
        }
        // Sort tiles
        tiles = tiles.sorted {
            $0.position.y < $1.position.y ||
            ($0.position.y == $1.position.y && $0.position.x < $1.position.x)
        }
    }
}
