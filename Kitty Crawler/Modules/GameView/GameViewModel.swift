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
                if Utils.chance(50),
                   amountsSpawned[.enemy, default: 0] < GameRules.maxTilePerLevel(type: .enemy, level: level) {
                    newTile.type = .enemy
                    newTile.power = getRandomPower(type: .enemy)
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

    func getRandomPower(type: TileType) -> Int {
        let minPower = GameRules.minPowerPerLevel(type: type, level: level)
        let maxPower = GameRules.minPowerPerLevel(type: type, level: level)
        return Int.random(in: minPower...maxPower)
    }
}
