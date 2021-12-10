//
//  RowView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

struct RowView: View {
    private let gridBoxes: [GridBox]
    private let isDisabled: Bool
    init(_ gridBoxes: [GridBox], isDisabled: Bool) {
        self.gridBoxes = gridBoxes
        self.isDisabled = isDisabled
    }
    var body: some View {
        HStack(spacing: CommonProperties.size.getMin(of: 1)) {
            ForEach(0..<gridBoxes.count) { index in
                BoxView(gridBoxes[index], isDisabled: isDisabled)
            }
        }
    }
}
