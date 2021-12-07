//
//  CaseView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

struct CaseView: View {
    @EnvironmentObject private var gridViewModel: GridViewModel
    @EnvironmentObject private var aiViewModel: AIViewModel
    @Binding private var rotation3DDegrees: Double
    private let player: Player
    private let row: String
    private let col: Int
    private let isDisabled: Bool
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State private var buttonHasBeenHitten: Bool = false
    init(_ player: Player, row: String, col: Int, isDisabled: Bool, rotationDegrees: Binding<Double>) {
        self.player = player
        self.row = row
        self.col = col
        self.isDisabled = isDisabled
        self._rotation3DDegrees = rotationDegrees
    }
    var body: some View {
        ZStack {
            RoundedRectangle()
                .foregroundColor(Color(player.colorName))
                .opacity(0.3)
            SymbolView(player.symbol)
            RoundedRectangle()
                .stroke()
                .foregroundColor(Color(player.colorName))
        }
        .inButton(isDisabled: player.int != 0 || isDisabled || gridViewModel.hasToWait || gridViewModel.currentPlayer == .me) {
            hit()
        }
        .rotation3DEffect(
            .degrees(rotation3DDegrees),
            axis: (x: 0.0, y: 1.0, z: 0.0))
        .animation(.linear(duration: 0.5))
        .onReceive(timer, perform: { _ in
            if rotation3DDegrees == 90 {
                gridViewModel.playerDidChoose(row: row, col: col)
                rotation3DDegrees = 180
            } else if rotation3DDegrees == 180 {
                if buttonHasBeenHitten {
                    buttonHasBeenHitten = false
                    gridViewModel.nextPlayer()
                    aiViewModel.endDecision()
                    if gridViewModel.currentPlayer == .me && !aiViewModel.decisionInProgress {
                        aiViewModel.play(grid: gridViewModel.grid)
                    }
                }
            } else {
                if gridViewModel.currentPlayer == .me, let decision = aiViewModel.decision, decision.row == row, decision.col == col {
                    aiViewModel.reset()
                    hit()
                }
            }
        })
    }
    private func hit() {
        buttonHasBeenHitten = true
        gridViewModel.forceWaiting()
        rotation3DDegrees = 90
    }
}

