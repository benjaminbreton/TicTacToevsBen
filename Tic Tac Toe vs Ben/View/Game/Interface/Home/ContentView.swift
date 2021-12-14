//
//  ContentView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Observed objects
    
    /// The ViewModel to call when an interaction with the grid is performed.
    @ObservedObject private var gridViewModel: GridViewModel
    /// The ViewModel to call when the AI has to play.
    @ObservedObject private var aiViewModel: AIViewModel
    
    // MARK: - State property
    
    /// A boolean indicating whether the device is portrait oriented or not.
    @State private var orientationIsPortrait = UIScreen.main.bounds.height > UIScreen.main.bounds.width
    
    // MARK: - Orientation's notification
    
    /// A notification used to know when the device's orientation changed
    private let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .makeConnectable()
            .autoconnect()
    /// A boolean indicating whether the grid has to be disabled or not.
    var isGridDisabled: Bool {
        !gridViewModel.canContinue || gridViewModel.victoriousPlayer != nil
    }
    
    // MARK: - Init
    
    init() {
        self.gridViewModel = GridViewModel()
        self.aiViewModel = AIViewModel()
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.appWhite
            if orientationIsPortrait {
                VStack {
                    TitleView()
                    GridView(isDisabled: isGridDisabled)
                    MessageView()
                    ResetView(reset: reset)
                }
            } else {
                HStack {
                    VStack {
                        TitleView()
                        MessageView()
                        ResetView(reset: reset)
                    }
                    GridView(isDisabled: isGridDisabled)
                }
            }
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
        .onReceive(orientationChanged, perform: { _ in
            orientationIsPortrait = UIScreen.main.bounds.height > UIScreen.main.bounds.width
        })
    }
    
    // MARK: - Reset
    
    /**
     The method to call to reset the grid.
     */
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
















