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
    private var gridSize: CGFloat { CommonProperties.size.getMin(of: 82) }
    private let reset: () -> Void
    @Binding private var boxHasBeenChoosen: Bool
    init(rotationDegrees: Binding<[[Double]]>, boxHasBeenChoosen: Binding<Bool>, reset: @escaping () -> Void) {
        self._rotationDegrees = rotationDegrees
        self.reset = reset
        self._boxHasBeenChoosen = boxHasBeenChoosen
    }
    var body: some View {
        VStack {
            Text("Tic Tac Toe vs Ben")
                .font(.appTitle)
                .inRoundedRectangle()
                .frame(height: CommonProperties.size.getMin(of: 10))
                .padding()
            ZStack {
                VStack(spacing: CommonProperties.size.getMin(of: 1)) {
                    ForEach(0..<gridViewModel.grid.count) { index in
                        RowView(gridViewModel.grid[index], row: rows[index], isDisabled: isGridDisabled, rotationDegrees: $rotationDegrees[index], boxHasBeenChoosen: $boxHasBeenChoosen)
                    }
                }
                VictoriousLineView()
            }
            .frame(width: gridSize, height: gridSize)
            Text(gridViewModel.gridMessage)
                .inRoundedRectangle(color: Color(gridViewModel.gridColorName))
                .frame(height: CommonProperties.size.getMin(of: 5))
                .padding()
            Text(isGridDisabled ? "Continuer" : "Reset")
                .inRoundedRectangle()
                .frame(height: CommonProperties.size.getMin(of: 10))
                .padding()
                .inButton(action: reset)
        }
    }
}
