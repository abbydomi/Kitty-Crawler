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
    @Published var score = 0
    @Published var health = 2
    @Published var maxHealth = 3
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
                // Spawn Healing
                if Utils.chance(60),
                   amountsSpawned[.heal, default: 0] < GameRules.maxTilePerLevel(type: .heal, level: level) {
                    newTile.type = .heal
                    newTile.power = getRandomPower(type: .heal)
                    amountsSpawned[.heal, default: 0] += 1
                    tiles.append(newTile)
                    continue
                }
                // Spawn Defense
                if Utils.chance(70),
                   amountsSpawned[.defense, default: 0] < GameRules.maxTilePerLevel(type: .defense, level: level) {
                    newTile.type = .defense
                    newTile.power = getRandomPower(type: .defense)
                    amountsSpawned[.defense, default: 0] += 1
                    tiles.append(newTile)
                    continue
                }
                // Spawn Attack
                if Utils.chance(80),
                   amountsSpawned[.attack, default: 0] < GameRules.maxTilePerLevel(type: .attack, level: level) {
                    newTile.type = .attack
                    newTile.power = getRandomPower(type: .attack)
                    amountsSpawned[.attack, default: 0] += 1
                    tiles.append(newTile)
                    continue
                }
                // Spawn Currency
                if Utils.chance(90),
                   amountsSpawned[.currency, default: 0] < GameRules.maxTilePerLevel(type: .currency, level: level) {
                    newTile.type = .currency
                    newTile.power = getRandomPower(type: .currency)
                    amountsSpawned[.currency, default: 0] += 1
                    tiles.append(newTile)
                    continue
                }
                // Random tile
                newTile = randomTile(for: newTile)
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

    func randomTile(for tile: Tile) -> Tile {
        var randomTile = tile
        let possibleTypes: [TileType] = [
            .attack,
            .defense,
            .currency,
            .heal,
            .store,
            .temple,
        ]
        var newtype = possibleTypes.randomElement() ?? .attack
        var newPower = 1
        let amountOfTile = amountsSpawned[newtype, default: 0]
        if amountOfTile > GameRules.maxTilePerLevel(type: newtype, level: level) {
            // max coin lucky draw
            newtype = .currency
            newPower = 3
        }

        randomTile.power = newPower
        randomTile.type = newtype

        return randomTile
    }
}
