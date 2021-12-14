//
//  SymbolView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

struct SymbolView: View {
    
    // MARK: - Computed property
    
    private var size: CGFloat { CommonProperties.size.getMin(of: 2) }
    
    // MARK: - Init property
    
    private let player: Player
    
    // MARK: - Init
    
    init(_ player: Player) {
        self.player = player
    }
    
    // MARK: - Body
    
    var body: some View {
        Group {
            if player == .ai {
                ZStack {
                    RoundedRectangle()
                        .frame(height: size)
                        .rotationEffect(.degrees(45))
                    RoundedRectangle()
                        .frame(height: size)
                        .rotationEffect(.degrees(-45))
                }
            } else if player == .player {
                Circle()
                    .stroke(lineWidth: size)
            }
        }
        .padding()
        .foregroundColor(player.color)
    }
}
