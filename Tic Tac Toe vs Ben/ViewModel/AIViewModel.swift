//
//  AIViewModel.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import Foundation
final class AIViewModel: ObservableObject {
    
    // MARK: - Published property
    
    @Published private var model: AI
    
    // MARK: - Computed properties
    
    var decision: GridBox? { model.decision }
    private(set) var decisionInProgress: Bool = false
    
    // MARK: - Init
    
    init() {
        model = AI()
    }
    
    // MARK: - Play
    
    /**
     Ask model to choose a box to play.
     */
    func play() {
        if !decisionInProgress {
            decisionInProgress = true
            model.decide()
        }
    }
    
    // MARK: - Reset
    
    /**
     Ask model to reset values when Views did know its decision.
     */
    func reset() {
        model.reset()
        decisionInProgress = false
    }
}
