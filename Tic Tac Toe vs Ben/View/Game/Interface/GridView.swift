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
    init(rotationDegrees: Binding<[[Double]]>, reset: @escaping () -> Void) {
        self._rotationDegrees = rotationDegrees
        self.reset = reset
    }
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle()
                    .foregroundColor(.appBlack)
                    .opacity(0.2)
                Text("Tic Tac Toe vs Ben")
                    .foregroundColor(.appBlack)
                RoundedRectangle()
                    .stroke()
                    .foregroundColor(.appBlack)
            }
            .frame(height: CommonProperties.shared.getHeight(of: 10))
            .padding()
            VStack(spacing: CommonProperties.shared.getMin(of: 1)) {
                ForEach(0..<gridViewModel.grid.count) { index in
                    RowView(gridViewModel.grid[index], row: rows[index], isDisabled: isGridDisabled, rotationDegrees: $rotationDegrees[index])
                }
            }
            .frame(width: gridSize, height: gridSize)
            ZStack {
                RoundedRectangle()
                    .foregroundColor(.appBlack)
                    .opacity(0.2)
                Text("Reset")
                    .foregroundColor(.appBlack)
                RoundedRectangle()
                    .stroke()
                    .foregroundColor(.appBlack)
            }
            .frame(height: CommonProperties.shared.getHeight(of: 10))
            .padding()
            .inButton(action: reset)
        }
    }
}


