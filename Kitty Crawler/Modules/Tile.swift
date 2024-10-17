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
}
