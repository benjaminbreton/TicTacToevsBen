//
//  RowView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

struct RowView: View {
    private let gridBoxes: [GridBox]
    private let row: String
    private let isDisabled: Bool
    @Binding private var rotationDegrees: [Double]
    @Binding private var boxHasBeenChoosen: Bool
    init(_ gridBoxes: [GridBox], row: String, isDisabled: Bool, rotationDegrees: Binding<[Double]>, boxHasBeenChoosen: Binding<Bool>) {
        self.gridBoxes = gridBoxes
        self.row = row
        self.isDisabled = isDisabled
        self._rotationDegrees = rotationDegrees
        self._boxHasBeenChoosen = boxHasBeenChoosen
    }
    var body: some View {
        HStack(spacing: CommonProperties.size.getMin(of: 1)) {
            ForEach(0..<gridBoxes.count) { index in
                BoxView(gridBoxes[index], row: row, col: index + 1, isDisabled: isDisabled, rotationDegrees: $rotationDegrees[index], boxHasBeenChoosen: $boxHasBeenChoosen)
            }
        }
    }
}
