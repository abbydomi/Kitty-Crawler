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
    @Published var health = 3
    @Published var maxHealth = 3
    @Published var attack: Item?
    @Published var defense: Item?
    @Published var backpack: [Item] = []
    private var amountsSpawned: [TileType: Int] = [:]

    init() {
        createBoard()
    }

    func handleTileTap(tile: Tile) {
        if adjacentTiles().contains(tile) {
            // emptyTile(at: tiles.firstIndex(where: { $0.id == tile.id }))
            movePlayer(to: tile)
        }
    }

    func handleItemTap() {
        // TODO: Handle using items
    }
}

private extension GameViewModel {
    func createBoard() {
        let coordinateXExit = Int.random(in: 1...5)

        let spawnRules = GameRules.spawnRules()

        for x in 1...5 {
            for y in 1...5 {
                var tile = Tile(
                    power: 0,
                    position: Position(x: x, y: y),
                    type: .empty
                )

                // Player entrance
                if x == 3 && y == 5 {
                    tile.type = .player
                    tiles.append(tile)
                    continue
                }

                // Exit
                if x == coordinateXExit && y == 1 {
                    tile.type = .exit
                    tiles.append(tile)
                    continue
                }

                // Spawn rules
                if let spawnedTile = spawnTile(using: spawnRules, baseTile: tile) {
                    tiles.append(spawnedTile)
                    continue
                }

                // Fallback random tile
                tiles.append(randomTile(for: tile))
            }
        }

        tiles.sort {
            $0.position.y < $1.position.y ||
            ($0.position.y == $1.position.y && $0.position.x < $1.position.x)
        }
    }

    func spawnTile(
        using rules: [SpawnRule],
        baseTile: Tile
    ) -> Tile? {
        for rule in rules {
            if Utils.chance(rule.chance),
               amountsSpawned[rule.type, default: 0] <
               GameRules.maxTilePerLevel(type: rule.type, level: level) {
                var tile = baseTile
                tile.type = rule.type
                tile.power = getRandomPower(type: rule.type)
                amountsSpawned[rule.type, default: 0] += 1
                return tile
            }
        }
        return nil
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
            .shop,
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
        guard let index = playerIndex() else { return }
        guard let tileIndex = tiles.firstIndex(where: { $0.id == tile.id }) else { return }

        withAnimation {
            interact(with: tile)
        }

        withAnimation(.easeOut) {
            tiles[tileIndex] = .init(power: 0, position: tile.position, type: .player)
        }
        emptyTile(at: index)
    }

    func emptyTile(at index: Int?) {
        guard let index else { return }
        tiles[index].type = .empty
    }

    func interact(with tile: Tile) {
        let type = tile.type

        switch type {
        case .empty, .player:
            return
        case .exit:
            // TODO: Next level logic
            break
        case .enemy:
            // TODO: Break Shield
            // TODO: Break Sword
            // TODO: Remove Health
            // TODO: Destroy Enemy
            break
        case .attack:
            attack = .init(power: tile.power, type: .attack)
        case .defense:
            defense = .init(power: tile.power, type: .defense)
        case .currency:
            // TODO: Add money
            break
        case .heal:
            health += tile.power
            if health > maxHealth {
                health = maxHealth
            }
        case .shop:
            // TODO: Navigate to shop
            break
        case .temple:
            // TODO: Navigate to Temple
            break
        }
    }
}
