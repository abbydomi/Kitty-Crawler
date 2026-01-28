//
//  GameViewModel.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 17/10/24.
//

import Combine
import Foundation
import SwiftUI

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

    func handleTileTap(tile: Tile) {
        if adjacentTiles().contains(tile) {
            // emptyTile(at: tiles.firstIndex(where: { $0.id == tile.id }))
            movePlayer(to: tile)
        }
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

    func adjacentTiles() -> [Tile?] {
        guard let playerTile = tiles.first(where: { $0.type == .player }) else {
            // There is no player?
            return [nil, nil, nil, nil]
        }

        let x = playerTile.position.x
        let y = playerTile.position.y

        return [
            tiles.first { $0.position.x == x && $0.position.y == y - 1 }, // UP
            tiles.first { $0.position.x == x && $0.position.y == y + 1 }, // DOWN
            tiles.first { $0.position.x == x - 1 && $0.position.y == y }, // LEFT
            tiles.first { $0.position.x == x + 1 && $0.position.y == y }, // RIGHT
        ]
    }

    func playerIndex() -> Int? {
        tiles.firstIndex { $0.type == .player }
    }

    func movePlayer(to tile: Tile) {
        if tile.type == .empty {
            return
        }

        // TODO: Interactions

        guard let index = playerIndex() else { return }
        guard let tileIndex = tiles.firstIndex(where: { $0.id == tile.id }) else { return }

        withAnimation(.easeOut) {
            tiles[tileIndex] = .init(power: 0, position: tile.position, type: .player)
        }
        emptyTile(at: index)
    }

    func emptyTile(at index: Int?) {
        guard let index else { return }
        tiles[index].type = .empty
    }
}
