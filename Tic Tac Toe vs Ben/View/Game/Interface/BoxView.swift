//
//  BoxView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

struct BoxView: View {
    @EnvironmentObject private var gridViewModel: GridViewModel
    @EnvironmentObject private var aiViewModel: AIViewModel
    private let box: GridBox
    private var owner: Player { box.owner }
    private let isDisabled: Bool
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    init(_ box: GridBox, isDisabled: Bool) {
        self.box = box
        self.isDisabled = isDisabled
    }
    var body: some View {
        ZStack {
            RoundedRectangle()
                .foregroundColor(Color(owner.colorName))
                .opacity(0.3)
            SymbolView(owner.symbol)
            RoundedRectangle()
                .stroke()
                .foregroundColor(Color(owner.colorName))
        }
        .inButton(isDisabled: owner.int != 0 || isDisabled || gridViewModel.hasToWait || gridViewModel.currentPlayer == .me, action: hit)
        .rotation3DEffect(
            .degrees(box.currentRotation),
            axis: (x: 0.0, y: 1.0, z: 0.0))
        .animation(.linear(duration: 0.5))
        .onReceive(timer, perform: { _ in
            if gridViewModel.currentPlayer == .me, let decision = aiViewModel.decision, decision == box, !gridViewModel.boxHasBeenChoosen {
                aiViewModel.reset()
                hit()
            }
        })
    }
    private func hit() {
        if gridViewModel.victoriousPlayer == nil {
            aiViewModel.reset()
            gridViewModel.boxButtonHasBeenHitten(box)
            waitForAction(.sendChoice)
        }
    }
    enum BoxAction {
        case sendChoice, endRound
    }
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
            }
        }
    }
    
}

