//
//  GridView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import SwiftUI

struct GridView: View {
    @EnvironmentObject private var gridViewModel: GridViewModel
    @EnvironmentObject private var aiViewModel: AIViewModel
    private let rows: [String] = "ABC".map({ "\($0)" })
    var isGridDisabled: Bool {
        !gridViewModel.canContinue || gridViewModel.victoriousPlayer != nil
    }
    @Binding private var rotationDegrees: [[Double]]
    private var gridSize: CGFloat { CommonProperties.shared.getMin(of: 82) }
    private let reset: () -> Void
    @Binding private var caseHasBeenChoosen: Bool
    init(rotationDegrees: Binding<[[Double]]>, caseHasBeenChoosen: Binding<Bool>, reset: @escaping () -> Void) {
        self._rotationDegrees = rotationDegrees
        self.reset = reset
        self._caseHasBeenChoosen = caseHasBeenChoosen
    }
    var body: some View {
        VStack {
            Text("Tic Tac Toe vs Ben")
                .inRoundedRectangle()
                .font(.appTitle)
                .frame(height: CommonProperties.shared.getHeight(of: 10))
                .padding()
            VStack(spacing: CommonProperties.shared.getMin(of: 1)) {
                ForEach(0..<gridViewModel.grid.count) { index in
                    RowView(gridViewModel.grid[index], row: rows[index], isDisabled: isGridDisabled, rotationDegrees: $rotationDegrees[index], caseHasBeenChoosen: $caseHasBeenChoosen)
                }
            }
            .frame(width: gridSize, height: gridSize)
            Text(gridViewModel.currentPlayer.text)
                .inRoundedRectangle(color: Color(gridViewModel.currentPlayer.colorName))
                .frame(height: CommonProperties.shared.getHeight(of: 5))
                .padding()
            Text("Reset")
                .inRoundedRectangle()
                .frame(height: CommonProperties.shared.getHeight(of: 10))
                .padding()
                .inButton(action: reset)
        }
    }
}


