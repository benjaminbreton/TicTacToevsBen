//
//  GridView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import SwiftUI

struct GridView: View {
    
    
    
    // MARK: - Environment object
    
    @EnvironmentObject private var gridViewModel: GridViewModel
    
    // MARK: - Computed properties
    
    private var gridSize: CGFloat { CommonProperties.size.getMin(of: 82) }
    
    // MARK: - Init property
    
    private var isDisabled: Bool
    
    // MARK: - Init
    
    init(isDisabled: Bool) {
        self.isDisabled = isDisabled
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            VStack(spacing: CommonProperties.size.getMin(of: 1)) {
                ForEach(0..<gridViewModel.grid.count) { index in
                    RowView(gridViewModel.grid[index], isDisabled: isDisabled)
                }
            }
            VictoriousLineView()
        }
        .frame(width: gridSize, height: gridSize)
    }
}
