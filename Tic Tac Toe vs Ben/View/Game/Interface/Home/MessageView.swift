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
    private var messageCode: String? {
        if gridViewModel.hasToWait {
            return nil
        } else if let player = gridViewModel.victoriousPlayer {
            return player.winMessageCode
        } else if gridViewModel.canContinue {
            return gridViewModel.currentPlayer.turnCode
        }
        return "draw"
    }
    private var message: String {
        messageCode?.localized ?? ""
    }
    
    // MARK: - Body
    
    var body: some View {
        Text(message)
            .inRoundedRectangle(color: color)
            .frame(height: CommonProperties.size.getMin(of: 5))
            .padding()
            .accessibility(identifier: "message")
            .accessibility(label: Text(messageCode ?? ""))
    }
}
