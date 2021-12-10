//
//  MessageView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

struct MessageView: View {
    @EnvironmentObject private var gridViewModel: GridViewModel
    @EnvironmentObject private var aiViewModel: AIViewModel
    private var messageSize: CGFloat {
        CommonProperties.size.getMin(of: 60)
    }
    private let reset: () -> Void
    init(reset: @escaping () -> Void) {
        self.reset = reset
    }
    var body: some View {
        ZStack {
            RoundedRectangle()
                .foregroundColor(.appWhite)
            VStack {
                Group {
                    if let player = gridViewModel.victoriousPlayer {
                        Text("\(player == .ai ? "J'ai gagné. Désolé." : "Tu as gagné, bravo !")")
                    } else {
                        Text("Match nul.")
                    }
                }
                Text("Continuer")
                    .inRoundedRectangle()
                    .inButton(action: reset)
                    .frame(height: messageSize / 6)
            }
            .padding()
            .foregroundColor(.appBlack)
            RoundedRectangle()
                .stroke()
                .foregroundColor(.appWhite)
        }
        .frame(width: messageSize, height: messageSize)
    }
}
