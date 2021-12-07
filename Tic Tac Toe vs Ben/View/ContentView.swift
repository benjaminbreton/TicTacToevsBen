//
//  ContentView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var gridViewModel: GridViewModel
    private var gridSize: CGFloat {
        CommonProperties.shared.getMin(of: 82)
    }
    private var messageSize: CGFloat {
        CommonProperties.shared.getMin(of: 40)
    }
    private let rows: [String] = ["A", "B", "C"]
    
    @State private var rotationDegrees: [[Double]] = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
    var isGridDisabled: Bool {
        !gridViewModel.canContinue || gridViewModel.victoriousPlayer != nil
    }
    init() {
        self.gridViewModel = GridViewModel()
    }
    var body: some View {
        ZStack {
            Color.appWhite
            VStack {
                ZStack {
                    RoundedRectangle()
                    Text("Tic Tac Toe vs Ben")
                    RoundedRectangle()
                        .stroke()
                }
                .frame(height: CommonProperties.shared.getHeight(of: 10))
                VStack(spacing: CommonProperties.shared.getMin(of: 1)) {
                    ForEach(0..<gridViewModel.grid.count) { index in
                        RowView(gridViewModel.grid[index], row: rows[index], isDisabled: isGridDisabled, rotationDegrees: $rotationDegrees[index])
                    }
                }
                .frame(width: gridSize, height: gridSize)
            }
            if isGridDisabled {
                ZStack {
                    RoundedRectangle()
                    VStack {
                        if let player = gridViewModel.victoriousPlayer {
                            Text("\(player == .me ? "J'ai gagné. Désolé." : "Tu as gagné, bravo !")")
                        } else {
                            Text("Match nul.")
                        }
                        Text("Continuer")
                            .inButton {
                                gridViewModel.reset()
                                rotationDegrees = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
                            }
                    }
                    RoundedRectangle()
                        .stroke()
                }
                .frame(width: messageSize, height: messageSize)
            }
        }
        .environmentObject(gridViewModel)
    }
}








