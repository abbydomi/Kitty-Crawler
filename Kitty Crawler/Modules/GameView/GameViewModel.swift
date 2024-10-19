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
    @Published var level = 1
    private var amountsSpawned: [TileType: Int] = [
        .enemy: 0
    ]

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
                // Player-Entrance tile
                if coordinateX == 3 && coordinateY == 5 {
                    newTile.type = .player
                    tiles.append(newTile)
                    continue
                }
                // Exit tile
                if coordinateX == coordinateXExit && coordinateY == 1 {
                    newTile.type = .exit
                    tiles.append(newTile)
                    continue
                }
                // Spawn enemies
                if Utils.chance(50) && amountsSpawned[.enemy, default: 0] < maxTilePerLevel(type: .enemy) {
                    newTile.type = .enemy
                    amountsSpawned[.enemy, default: 0] += 1
                    tiles.append(newTile)
                    continue
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

    func maxTilePerLevel(type: TileType) -> Int {
        switch type {
        case .enemy:
            let maxAmounts = [
                12, 12, 12, 12,         // 1 - 4
                14, 14, 14, 14, 14,     // 5- 9
                16, 16, 16, 16, 16, 16, // 10 - 15
                17, 17, 17, 17, 17,     // 16 - 20
            ]
            return level < maxAmounts.count ? maxAmounts[level] : maxAmounts.last ?? 17
        default:
            return 1
        }
    }
}
