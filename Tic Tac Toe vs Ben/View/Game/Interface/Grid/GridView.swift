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
    
    private var gridSize: CGFloat {
        guard orientationIsPortrait || CommonProperties.size.getMax(of: 45) > CommonProperties.size.getMin(of: 82) else { return CommonProperties.size.getMax(of: 45) }
        return CommonProperties.size.getMin(of: 82)
    }
    
    // MARK: - Init property
    
    private var isDisabled: Bool
    private let orientationIsPortrait: Bool
    
    // MARK: - Init
    
    init(isDisabled: Bool, orientationIsPortrait: Bool) {
        self.isDisabled = isDisabled
        self.orientationIsPortrait = orientationIsPortrait
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
