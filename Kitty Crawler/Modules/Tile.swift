//
//  Tile.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 17/10/24.
//

import SwiftUI

struct Tile: Hashable, Identifiable {
    let id: String
    var power: Int
    var position: Position
    var type: TileType

    var image: ImageResource {
        if power == 0 {
            return ImageResource(name: "\(type)", bundle: .main)
        }
        return ImageResource(name: "\(type)_\(power)", bundle: .main)
    }

    init(power: Int, position: Position, type: TileType) {
        self.id = UUID().uuidString
        self.power = power
        self.position = position
        self.type = type
    }
}

struct Position: Hashable {
    var x: Int
    var y: Int
}

enum TileType {
    case empty
    case exit
    case enemy
    case player
    case attack    // Sword
    case defense   // Shield
    case currency  // Coin
    case heal
    case shop
    case temple
}
