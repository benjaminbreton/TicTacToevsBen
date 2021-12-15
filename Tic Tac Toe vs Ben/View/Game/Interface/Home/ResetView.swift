//
//  ResetView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 14/12/2021.
//

import SwiftUI

struct ResetView: View {
    
    // MARK: - Environment object
    
    @EnvironmentObject private var gridViewModel: GridViewModel
    
    // MARK: - Computed property
    
    private var isGridDisabled: Bool {
        !gridViewModel.canContinue || gridViewModel.victoriousPlayer != nil
    }
    
    // MARK: - Init property
    
    private let reset: () -> Void
    
    // MARK: - Init
    
    init(reset: @escaping () -> Void) {
        self.reset = reset
    }
    
    // MARK: - Body
    
    var body: some View {
        Text(isGridDisabled ? "continue".localized : "reset".localized)
            .inRoundedRectangle()
            .frame(height: CommonProperties.size.getMin(of: 10))
            .padding()
            .inButton("reset", action: reset)
    }
}
