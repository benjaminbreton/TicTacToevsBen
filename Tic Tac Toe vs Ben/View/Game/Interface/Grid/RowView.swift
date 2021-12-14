//
//  RowView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

struct RowView: View {
    
    // MARK: - Init properties
    
    private let rowBoxes: [GridBox]
    private let isDisabled: Bool
    
    // MARK: - Init
    
    init(_ rowBoxes: [GridBox], isDisabled: Bool) {
        self.rowBoxes = rowBoxes
        self.isDisabled = isDisabled
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: CommonProperties.size.getMin(of: 1)) {
            ForEach(0..<rowBoxes.count) { index in
                BoxView(rowBoxes[index], isDisabled: isDisabled)
            }
        }
    }
}
