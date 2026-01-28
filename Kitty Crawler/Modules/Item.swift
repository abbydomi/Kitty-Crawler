//
//  Item.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 28/1/26.
//

import SwiftUI

struct Item: Hashable, Identifiable {
    let id: String
    let power: Int
    var type: TileType

    init(power: Int, type: TileType) {
        id = UUID().uuidString
        self.power = power
        self.type = type
    }

    var image: ImageResource {
        if power == 0 {
            return ImageResource(name: "\(type)", bundle: .main)
        }
        return ImageResource(name: "\(type)_\(power)", bundle: .main)
    }

    init(id: String, power: Int, type: TileType) {
        self.id = id
        self.power = power
        self.type = type
    }
}
