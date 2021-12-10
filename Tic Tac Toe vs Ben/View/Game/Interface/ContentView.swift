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
    init() {
        self.gridViewModel = GridViewModel()
        self.aiViewModel = AIViewModel()
    }
    
    var body: some View {
        ZStack {
            Color.appWhite
            GridView(reset: reset)
        }
        .font(.appRegular)
        .environmentObject(gridViewModel)
        .environmentObject(aiViewModel)
        .onReceive(gridViewModel.$aiHasToPlay, perform: { hasToPlay in
            if gridViewModel.currentPlayer == .ai, !aiViewModel.decisionInProgress, hasToPlay {
                gridViewModel.aiIsPlaying()
                aiViewModel.play()
            }
        })
    }
    private func reset() {
        aiViewModel.reset()
        gridViewModel.reset()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if gridViewModel.currentPlayer == .ai {
                aiViewModel.play()
            }
        }
    }
}
















