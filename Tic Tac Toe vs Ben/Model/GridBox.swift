//
//  GridBox.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import Foundation
enum GridBox: CaseIterable {
    
    // MARK: - Cases
    
                                // Rows / Cols | 1 | 2 | 3 |
                                // ____________|___|___|___|
    case boxA1, boxA2, boxA3    // A           |   |   |   |
                                // ____________|___|___|___|
    case boxB1, boxB2, boxB3    // B           |   |   |   |
                                // ____________|___|___|___|
    case boxC1, boxC2, boxC3    // C           |   |   |   |
                                // ____________|___|___|___|
    
    // MARK: - Owner
    
    /// The owner of this box.
    var owner: Player {
        get { Player.getFromInt(savedValue) }
        set { savedValue = newValue.int }
    }
    /// Property used to save the owner in UserDefaults.
    private var savedValue: Int {
        get {
            getUserDefault("box\(row)\(col)", defaultValue: 0)
        }
        set {
            setUserDefault("box\(row)\(col)", value: newValue)
        }
    }
    var currentRotation: Double {
        get {
            getUserDefault("rotation\(row)\(col)", defaultValue: 0)
        }
        set {
            setUserDefault("rotation\(row)\(col)", value: newValue)
        }
    }
    private func getUserDefault<Type>(_ name: String, defaultValue: Type) -> Type {
        UserDefaults.standard.object(forKey: name) as? Type ?? defaultValue
    }
    private func setUserDefault<Type>(_ name: String, value: Type) {
        UserDefaults.standard.setValue(value, forKey: name)
    }
    
    // MARK: - Rows
    
    /// The row's index in the grid for the box.
    var rowsIndex: Int {
        switch self {
        case .boxA1, .boxA2, .boxA3:
            return 0
        case .boxB1, .boxB2, .boxB3:
            return 1
        case .boxC1, .boxC2, .boxC3:
            return 2
        }
    }
    /// Rows of the grid.
    private var rows: [String] { ["A", "B", "C"] }
    /// The row's letter for the box.
    var row: String { rows[rowsIndex] }
    
    // MARK: - Cols
    
    /// The col's index in the grid for the box.
    var colsIndex: Int {
        switch self {
        case .boxA1, .boxB1, .boxC1:
            return 0
        case .boxA2, .boxB2, .boxC2:
            return 1
        case .boxA3, .boxB3, .boxC3:
            return 2
        }
    }
    /// The col's number for the box
    var col: Int { colsIndex + 1 }
    
    // MARK: - Position in the grid
    
    /// Boolean indicating whether the box is situated in the middle of two corners (except the center box), or not.
    var isMiddleCorner: Bool { (rowsIndex == 1 || colsIndex == 1) && (rowsIndex != colsIndex) }
    /// Boolean indicating whether the box is situated on the grid's center or not.
    var isCenter: Bool { self == .boxB2 }
    /// Boolean indicating whether the box is situated on a grid's corner or not.
    var isCorner: Bool { (rowsIndex == 0 || rowsIndex == 2) && (colsIndex == 0 || colsIndex == 2) }
    
    // MARK: - Opposite position
    
    /// Get the box situated at the opposite on the grid of this one.
    var oppositeBox: GridBox {
        let col = self.col == 1 ? 3 : self.col == 3 ? 1 : 2
        let row = self.row == "A" ? "C" : self.row == "C" ? "A" : "B"
        return GridBox.getBox(row: row, col: col)
    }
    
    // MARK: - GridLines
    
    /// All GridLines containing the GridBox.
    var gridLines: [GridLine] {
        GridLine.allCases.compactMap({ $0.gridBoxes.contains(self) ? $0 : nil })
    }
    
    // MARK: - Get box
    
    /**
     Method returning a GridBox regarding its row's letter and col's number.
     - parameter row: The row's letter of the box.
     - parameter col: The col's number of the box.
     - returns: The GridBox.
     */
    static func getBox(row: String, col: Int) -> GridBox {
        let result = allCases.compactMap({ $0.row == row && $0.col == col ? $0 : nil})
        if result.count == 1 {
            return result[0]
        }
        return .boxA1
    }
}
