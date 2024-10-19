//
//  HealthUIView.swift
//  Kitty Crawler
//
//  Created by Abby Dominguez on 19/10/24.
//

import SwiftUI

// MARK: - View
struct HealthUIView: View {
    var viewModel: GameViewModel
    private var healthBarPC: Float {
        Float(viewModel.health) == 0 ? 0 : Float(viewModel.health) / Float(viewModel.maxHealth)
    }

    enum Constants {
        static let height: CGFloat = 32
        static let healthBarWidth: CGFloat = 100
    }

    var body: some View {
        HStack {
            Image(.heart)
                .resizable()
                .scaledToFit()
                .accessibilityLabel("Health-icon")
                .padding(.trailing, -4)
            Text(":")
                .modifier(TextUIModifiers())
            ZStack {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: Constants.healthBarWidth)
                        .foregroundStyle(.blue)
                    Rectangle()
                        .frame(width: CGFloat(Float(Constants.healthBarWidth) * healthBarPC))
                        .foregroundColor(.red)
                }
                .border(.white)
                HStack {
                    Text("\(viewModel.health)")
                        .modifier(TextUIModifiers())
                    Text("/")
                        .modifier(TextUIModifiers())
                    Text("\(viewModel.maxHealth)")
                        .modifier(TextUIModifiers())
                }
            }
        }
        .frame(height: Constants.height)
    }
}

// MARK: - Preview
#Preview {
    GameView()
}
