//
//  AIViewModel.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import Foundation
class AIViewModel: ObservableObject {
    @Published private var model: AI
    var decision: GridCase? { model.decision }
    private(set) var decisionInProgress: Bool = false
    init() {
        model = AI()
    }
    func play(grid: [[Player]]) {
        decisionInProgress = true
        model.decide(grid: grid)
    }
    func reset() {
        model.reset()
    }
    func endDecision() {
        decisionInProgress = false
    }
}
