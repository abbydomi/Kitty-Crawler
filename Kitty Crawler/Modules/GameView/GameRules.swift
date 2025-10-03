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
            let defaultValue = 17
            let maxAmounts = [
                12, 12, 12, 12,         // 1 - 4
                14, 14, 14, 14, 14,     // 5 - 9
                16, 16, 16, 16, 16, 16, // 10 - 15
                17, 17, 17, 17, 17,     // 16 - 20
            ]
            return level < maxAmounts.count ? maxAmounts[level] : defaultValue
        case .sword:
            let defaultValue = 4
            let maxAmounts = [
                4,                         // 1
                5, 5, 5, 5, 5, 5, 5, 5, 5, // 2 - 10
                4, 4, 4,                   // 11 - 13
                3, 3,                      // 14 - 15
                6, 6, 6, 6,                // 16 - 19
                3,                         // 20
            ]
            return level < maxAmounts.count ? maxAmounts[level] : defaultValue
        default:
            return 1
        }
    }
    // MARK: - Power amounts
    static func maxPowerPerLevel(type: TileType, level: Int) -> Int {
        switch type {
        case .enemy:
            let defaultValue = 7
            let maxPower = [
                2, 2,             // 1 - 2
                3, 3, 3, 3,       // 4 - 6
                4, 4, 4, 4,       // 7 - 10
                5,                // 11
                6, 6, 6, 6, 6, 6, // 12 - 17
                7, 7, 7,          // 18 - 20
            ]
            return level < maxPower.count ? maxPower[level] : defaultValue
        case .sword:
            let defaultValue = 5
            let maxPower = [
                2, 2,                // 1 - 2
                3, 3, 3, 3, 3, 3, 3, // 3 - 9
                4, 4, 4, 4,          // 10 - 13
                3, 3, 3,             // 14 - 16
                4,                   // 17
                5, 5, 5,             // 18 - 20
            ]
            return level < maxPower.count ? maxPower[level] : defaultValue
        default:
            return 7
        }
    }

    static func minPowerPerLevel(type: TileType, level: Int) -> Int {
        switch type {
        case .enemy:
            let defaultValue = 5
            let minPower = [
                1, 1, 1, 1, 1, 1,    // 1 - 6
                2, 2, 2, 2, 2, 2, 2, // 7 - 13
                3, 3, 3,             // 14 - 16
                4, 4,                // 17 - 18
                5, 5,                // 19 - 20
            ]
            return level < minPower.count ? minPower[level] : defaultValue
        case .sword:
            let defaultValue = 3
            let minPower = [
                1, 1, 1, 1, 1, 1, // 1 - 6
                2, 2, 2, 2, 2, 2, 2, // 7 - 13
                3, 3, 3, 3, 3, // 14 - 18
                4, // 19
                3, // 20
            ]
            return level < minPower.count ? minPower[level] : defaultValue
        default:
            return 1
        }
    }
}
