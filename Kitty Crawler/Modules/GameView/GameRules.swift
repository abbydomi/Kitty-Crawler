//
//  GameRules.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 19/10/24.
//

class GameRules {
    // MARK: - Tile amounts
    static func maxTilePerLevel(type: TileType, level: Int) -> Int {
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
    // MARK: - Power amounts
    static func maxPowerPerLevel(type: TileType, level: Int) -> Int {
        switch type {
        case .enemy:
            let maxPower = [
                2, 2,             // 1 - 2
                3, 3, 3, 3,       // 4 - 6
                4, 4, 4, 4,       // 7 - 10
                5,                // 11
                6, 6, 6, 6, 6, 6, // 12 - 17
                7, 7, 7           // 18 - 20
            ]
            return level < maxPower.count ? maxPower[level] : maxPower.last ?? 7
        default:
            return 7
        }
    }

    static func minPowerPerLevel(type: TileType, level: Int) -> Int {
        switch type {
        case .enemy:
            let minPower = [
                1, 1, 1, 1, 1, 1,    // 1 - 6
                2, 2, 2, 2, 2, 2, 2, // 7 - 13
                3, 3, 3,             // 14 - 16
                4, 4,                // 17 - 18
                5, 5                 // 19 -20
            ]
            return level < minPower.count ?  minPower[level] : minPower.last ?? 5
        default:
            return 1
        }
    }
}
