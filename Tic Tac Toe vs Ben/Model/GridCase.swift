//
//  GridCase.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import Foundation
enum GridCase: CaseIterable {
    case caseA1, caseA2, caseA3, caseB1, caseB2, caseB3, caseC1, caseC2, caseC3
    private var rows: [String] { ["A", "B", "C"] }
    var firstIndex: Int {
        switch self {
        case .caseA1, .caseA2, .caseA3:
            return 0
        case .caseB1, .caseB2, .caseB3:
            return 1
        case .caseC1, .caseC2, .caseC3:
            return 2
        }
    }
    var secondIndex: Int {
        switch self {
        case .caseA1, .caseB1, .caseC1:
            return 0
        case .caseA2, .caseB2, .caseC2:
            return 1
        case .caseA3, .caseB3, .caseC3:
            return 2
        }
    }
    var isMiddleCorner: Bool { (firstIndex == 1 || secondIndex == 1) && (firstIndex != secondIndex) }
    var isMiddle: Bool { self == .caseB2 }
    var isCorner: Bool { (firstIndex == 0 || firstIndex == 2) && (secondIndex == 0 || secondIndex == 2) }
    var row: String { rows[firstIndex] }
    var col: Int { secondIndex + 1 }
    static func getCase(row: String, col: Int) -> GridCase {
        let result = allCases.compactMap({ $0.row == row && $0.col == col ? $0 : nil})
        if result.count == 1 {
            return result[0]
        }
        return .caseA1
    }
    static var allCasesMultipleArray: [[GridCase]] {
        [allCases.compactMap({ $0.firstIndex == 0 ? $0 : nil }),
         allCases.compactMap({ $0.firstIndex == 1 ? $0 : nil }),
         allCases.compactMap({ $0.firstIndex == 2 ? $0 : nil })]
    }
}
