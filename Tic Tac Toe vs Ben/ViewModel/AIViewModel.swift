//
//  AIViewModel.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import Foundation
class AIViewModel: ObservableObject {
    @Published private var model: AI
    var decision: GridBox? { model.decision }
    private(set) var decisionInProgress: Bool = false
    init() {
        model = AI()
    }
    func play() {
        if !decisionInProgress {
            decisionInProgress = true
            model.decide()
        }
    }
    func reset() {
        model.reset()
        decisionInProgress = false
    }
}
