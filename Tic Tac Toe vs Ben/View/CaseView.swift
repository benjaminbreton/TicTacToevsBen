//
//  CaseView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

struct CaseView: View {
    @EnvironmentObject private var gridViewModel: GridViewModel
    private let player: Player
    private let row: String
    private let col: Int
    private let isDisabled: Bool
    init(_ player: Player, row: String, col: Int, isDisabled: Bool) {
        self.player = player
        self.row = row
        self.col = col
        self.isDisabled = isDisabled
    }
    var body: some View {
        ZStack {
            RoundedRectangle()
            Text(player.symbol)
            RoundedRectangle()
                .stroke()
                .foregroundColor(.red)
        }
        .inButton(isDisabled: player.int != 0 || isDisabled) {
            gridViewModel.playerDidChoose(row: row, col: col)
        }
    }
}
