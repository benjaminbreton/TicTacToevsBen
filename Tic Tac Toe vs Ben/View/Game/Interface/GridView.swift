//
//  GridView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import SwiftUI

struct GridView: View {
    @EnvironmentObject private var gridViewModel: GridViewModel
    @EnvironmentObject private var aiViewModel: AIViewModel
    var isGridDisabled: Bool {
        !gridViewModel.canContinue || gridViewModel.victoriousPlayer != nil
    }
    private var gridSize: CGFloat { CommonProperties.size.getMin(of: 82) }
    private let reset: () -> Void
    private var color: Color {
        if let player = gridViewModel.victoriousPlayer {
            return player.color
        }
        return gridViewModel.currentPlayer.color
    }
    private var message: String {
        if let player = gridViewModel.victoriousPlayer {
            return player.winMessage
        } else if gridViewModel.canContinue {
            return gridViewModel.currentPlayer.text
        }
        return "match nul"
    }
    init(reset: @escaping () -> Void) {
        self.reset = reset
    }
    var body: some View {
        VStack {
            Text("Tic Tac Toe vs Ben")
                .font(.appTitle)
                .inRoundedRectangle()
                .frame(height: CommonProperties.size.getMin(of: 10))
                .padding()
            ZStack {
                VStack(spacing: CommonProperties.size.getMin(of: 1)) {
                    ForEach(0..<gridViewModel.grid.count) { index in
                        RowView(gridViewModel.grid[index], isDisabled: isGridDisabled)
                    }
                }
                VictoriousLineView()
            }
            .frame(width: gridSize, height: gridSize)
            Text(message)
                .inRoundedRectangle(color: color)
                .frame(height: CommonProperties.size.getMin(of: 5))
                .padding()
            Text(isGridDisabled ? "Continuer" : "Reset")
                .inRoundedRectangle()
                .frame(height: CommonProperties.size.getMin(of: 10))
                .padding()
                .inButton(action: reset)
        }
    }
}
