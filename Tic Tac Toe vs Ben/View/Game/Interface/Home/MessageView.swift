//
//  MessageView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 14/12/2021.
//

import SwiftUI

struct MessageView: View {
    
    // MARK: - Environment object
    
    @EnvironmentObject private var gridViewModel: GridViewModel
    
    // MARK: - Computed properties
    
    private var color: Color {
        if let player = gridViewModel.victoriousPlayer {
            return player.color
        }
        return gridViewModel.currentPlayer.color
    }
    private var message: String {
        if gridViewModel.hasToWait {
            return ""
        } else if let player = gridViewModel.victoriousPlayer {
            return player.winMessage
        } else if gridViewModel.canContinue {
            return gridViewModel.currentPlayer.text
        }
        return "draw".localized
    }
    
    // MARK: - Body
    
    var body: some View {
        Text(message)
            .inRoundedRectangle(color: color)
            .frame(height: CommonProperties.size.getMin(of: 5))
            .padding()
    }
}
