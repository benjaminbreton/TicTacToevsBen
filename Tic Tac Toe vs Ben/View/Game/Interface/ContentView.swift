//
//  ContentView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var gridViewModel: GridViewModel
    @ObservedObject private var aiViewModel: AIViewModel
    var isGridDisabled: Bool {
        !gridViewModel.canContinue || gridViewModel.victoriousPlayer != nil
    }
    @State private var rotationDegrees: [[Double]] = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
    @State private var boxHasBeenChoosen: Bool = false
    init() {
        self.gridViewModel = GridViewModel()
        self.aiViewModel = AIViewModel()
    }
    
    var body: some View {
        ZStack {
            Color.appWhite
            GridView(rotationDegrees: $rotationDegrees, boxHasBeenChoosen: $boxHasBeenChoosen, reset: reset)
        }
        .font(.appRegular)
        .environmentObject(gridViewModel)
        .environmentObject(aiViewModel)
        .onReceive(gridViewModel.$aiHasToPlay, perform: { hasToPlay in
            if gridViewModel.currentPlayer == .me, !aiViewModel.decisionInProgress, hasToPlay {
                gridViewModel.aiIsPlaying()
                aiViewModel.play(grid: gridViewModel.grid)
            }
        })
    }
    private func reset() {
        aiViewModel.reset()
        gridViewModel.reset()
        rotationDegrees = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if gridViewModel.currentPlayer == .me {
                aiViewModel.play(grid: gridViewModel.grid)
            }
        }
    }
}
















