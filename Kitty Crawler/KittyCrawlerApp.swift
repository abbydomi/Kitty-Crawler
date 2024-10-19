//
//  KittyCrawlerApp.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 17/10/24.
//

import SwiftUI

@main
struct KittyCrawlerApp: App {
    var body: some Scene {
        WindowGroup {
            GameView()
                .environment(\.font, .nunito(size: 16))
        }
    }
}
