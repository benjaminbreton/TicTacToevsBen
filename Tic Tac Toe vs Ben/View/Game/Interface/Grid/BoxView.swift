//
//  BoxView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

struct BoxView: View {
    
    // MARK: - Environment objects
    
    @EnvironmentObject private var gridViewModel: GridViewModel
    @EnvironmentObject private var aiViewModel: AIViewModel
    
    // MARK: - State property
    
    /// Timer used to check if AI has choosed a box.
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    // MARK: - Init properties
    
    private let box: GridBox
    private let isDisabled: Bool
    
    
    // MARK: - Init
    
    init(_ box: GridBox, isDisabled: Bool) {
        self.box = box
        self.isDisabled = isDisabled
    }
    
    // MARK: - Body
    
    var body: some View {
        box.owner.symbol
            .inRoundedRectangle(color: box.owner.color, padding: false)
            .inButton(isDisabled: box.owner != .none || isDisabled || gridViewModel.hasToWait || gridViewModel.currentPlayer != .player, action: hit)
            .rotation3DEffect(
                .degrees(box.currentRotation),
                axis: (x: 0.0, y: 1.0, z: 0.0))
            .animation(.linear(duration: 0.5))
            .onReceive(timer, perform: { _ in
                if gridViewModel.currentPlayer == .ai, let decision = aiViewModel.decision, decision == box, !gridViewModel.boxHasBeenChoosen {
                    aiViewModel.reset()
                    waitForAction(.hit)
                }
            })
    }
    
    // MARK: - Supporting methods
    
    /**
     Method called when the box is hitten by the player or the AI.
     */
    private func hit() {
        if gridViewModel.victoriousPlayer == nil {
            aiViewModel.reset()
            gridViewModel.boxButtonHasBeenHitten(box)
            waitForAction(.sendChoice)
        }
    }
    /// Enum used for the method whaitForAction.
    enum BoxAction { case hit, sendChoice, endRound }
    /**
     Method used to wait for an animation to end before performing the next action.
     - parameter action: The action to perform after the deadline.
     */
    private func waitForAction(_ action: BoxAction) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            switch action {
            case .sendChoice:
                if !gridViewModel.resetButtonHasBeenHitten {
                    gridViewModel.playerDidChoose(box)
                    waitForAction(.endRound)
                }
            case .endRound:
                if !gridViewModel.resetButtonHasBeenHitten {
                    gridViewModel.nextPlayer()
                }
            case .hit:
                if gridViewModel.currentPlayer == .ai {
                    hit()
                }
            }
        }
    }
    
}

