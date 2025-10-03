//
//  Tile.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 17/10/24.
//

struct Tile: Hashable {
    var power: Int
    var position: Position
    var type: TileType

    var image: ImageResource {
        if power == 0 {
            return ImageResource(name: "\(type)", bundle: .main)
        }
        return ImageResource(name: "\(type)_\(power)", bundle: .main)
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
    case sword
}
