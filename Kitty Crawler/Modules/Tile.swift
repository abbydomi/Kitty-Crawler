//
//  Tile.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 17/10/24.
//

struct Tile: Hashable {
    var power: Int
    var position: Position
}

struct Position: Hashable {
    var x: Int
    var y: Int
}
