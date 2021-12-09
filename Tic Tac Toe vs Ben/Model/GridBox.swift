//
//  GridBox.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import Foundation
enum GridBox: CaseIterable {
    case boxA1, boxA2, boxA3, boxB1, boxB2, boxB3, boxC1, boxC2, boxC3
    private var rows: [String] { ["A", "B", "C"] }
    var firstIndex: Int {
        switch self {
        case .boxA1, .boxA2, .boxA3:
            return 0
        case .boxB1, .boxB2, .boxB3:
            return 1
        case .boxC1, .boxC2, .boxC3:
            return 2
        }
    }
    var secondIndex: Int {
        switch self {
        case .boxA1, .boxB1, .boxC1:
            return 0
        case .boxA2, .boxB2, .boxC2:
            return 1
        case .boxA3, .boxB3, .boxC3:
            return 2
        }
    }
    var isMiddleCorner: Bool { (firstIndex == 1 || secondIndex == 1) && (firstIndex != secondIndex) }
    var isMiddle: Bool { self == .boxB2 }
    var isCorner: Bool { (firstIndex == 0 || firstIndex == 2) && (secondIndex == 0 || secondIndex == 2) }
    var row: String { rows[firstIndex] }
    var col: Int { secondIndex + 1 }
    static func getBox(row: String, col: Int) -> GridBox {
        let result = allCases.compactMap({ $0.row == row && $0.col == col ? $0 : nil})
        if result.count == 1 {
            return result[0]
        }
        return .boxA1
    }
    static var allBoxesMultipleArray: [[GridBox]] {
        [allCases.compactMap({ $0.firstIndex == 0 ? $0 : nil }),
         allCases.compactMap({ $0.firstIndex == 1 ? $0 : nil }),
         allCases.compactMap({ $0.firstIndex == 2 ? $0 : nil })]
    }
}
