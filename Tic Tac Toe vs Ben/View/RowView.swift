//
//  RowView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

struct RowView: View {
    private let rowDatas: [Player]
    private let row: String
    private let isDisabled: Bool
    init(_ rowDatas: [Player], row: String, isDisabled: Bool) {
        self.rowDatas = rowDatas
        self.row = row
        self.isDisabled = isDisabled
    }
    var body: some View {
        HStack(spacing: CommonProperties.shared.getMin(of: 1)) {
            ForEach(0..<rowDatas.count) { index in
                CaseView(rowDatas[index], row: row, col: index + 1, isDisabled: isDisabled)
            }
        }
    }
}
