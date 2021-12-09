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
    @Binding private var rotation3DDegrees: Double
    private let box: GridBox
    private var owner: Player { box.owner }
    private let row: String
    private let col: Int
    private let isDisabled: Bool
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @Binding private var boxHasBeenChoosen: Bool
    init(_ box: GridBox, row: String, col: Int, isDisabled: Bool, rotationDegrees: Binding<Double>, boxHasBeenChoosen: Binding<Bool>) {
        self.box = box
        self.row = row
        self.col = col
        self.isDisabled = isDisabled
        self._rotation3DDegrees = rotationDegrees
        self._boxHasBeenChoosen = boxHasBeenChoosen
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
            .degrees(rotation3DDegrees),
            axis: (x: 0.0, y: 1.0, z: 0.0))
        .animation(.linear(duration: 0.5))
        .onReceive(timer, perform: { _ in
            if gridViewModel.currentPlayer == .me, let decision = aiViewModel.decision, decision.row == row, decision.col == col, !boxHasBeenChoosen {
                aiViewModel.reset()
                hit()
            }
        })
    }
    private func hit() {
        boxHasBeenChoosen = true
        aiViewModel.reset()
        gridViewModel.forceWaiting()
        rotation3DDegrees = gridViewModel.currentPlayer.rotation90
        waitForAction(.sendChoice)
    }
    enum BoxAction {
        case sendChoice, endRound
    }
    private func waitForAction(_ action: BoxAction) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            switch action {
            case .sendChoice:
                gridViewModel.playerDidChoose(row: row, col: col)
                rotation3DDegrees = gridViewModel.currentPlayer.rotation180
                waitForAction(.endRound)
            case .endRound:
                boxHasBeenChoosen = false
                gridViewModel.nextPlayer()
                
            }
        }
    }
    
}

