//
//  Utils.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 18/10/24.
//

class Utils {
    static func chance(_ percentage: Int) -> Bool {
        let clampedPercentage = max(0, min(percentage, 100))
        let randomValue = Int.random(in: 1...100)
        return randomValue < clampedPercentage
    }
}
