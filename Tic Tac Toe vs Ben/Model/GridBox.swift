//
//  GridBox.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import Foundation
enum GridBox: CaseIterable {
    
    // MARK: - Cases
    
                                // Rows / Cols | 0 | 1 | 2 |
                                // ____________|___|___|___|
    case box00, box01, box02    // 0           |   |   |   |
                                // ____________|___|___|___|
    case box10, box11, box12    // 1           |   |   |   |
                                // ____________|___|___|___|
    case box20, box21, box22    // 2           |   |   |   |
                                // ____________|___|___|___|
    
    // MARK: - Saved properties
    
    /// The owner of this box.
    var owner: Player {
        Player.getFromInt(getUserDefault("boxOwner\(row)\(col)", defaultValue: 0))
    }
    /// The current rotation of the box in the grid.
    var currentRotation: Double {
        getUserDefault("boxRotation\(row)\(col)", defaultValue: 0)
    }
    /**
     Method used to get UserDefaults data.
     - parameter name: The key's name.
     - parameter defaultValue: The default value to set.
     - returns: The UserDefaults data.
     */
    private func getUserDefault<Value>(_ name: String, defaultValue: Value) -> Value {
        UserDefaults.standard.object(forKey: name) as? Value ?? defaultValue
    }
    
    // MARK: - Rows
    
    /// The row's index in the grid for the box.
    var row: Int {
        switch self {
        case .box00, .box01, .box02:
            return 0
        case .box10, .box11, .box12:
            return 1
        case .box20, .box21, .box22:
            return 2
        }
    }
    
    // MARK: - Cols
    
    /// The col's index in the grid for the box.
    var col: Int {
        switch self {
        case .box00, .box10, .box20:
            return 0
        case .box01, .box11, .box21:
            return 1
        case .box02, .box12, .box22:
            return 2
        }
    }
    
    // MARK: - Position in the grid
    
    /// Boolean indicating whether the box is situated in the middle of two corners (except the center box), or not.
    var isMiddleCorner: Bool { (row == 1 || col == 1) && (row != col) }
    /// Boolean indicating whether the box is situated on the grid's center or not.
    var isCenter: Bool { self == .box11 }
    /// Boolean indicating whether the box is situated on a grid's corner or not.
    var isCorner: Bool { (row == 0 || row == 2) && (col == 0 || col == 2) }
    
    // MARK: - Opposite position
    
    /// Get the box situated at the opposite on the grid of this one.
    var oppositeBox: GridBox {
        let col = self.col == 0 ? 2 : self.col == 2 ? 0 : 1
        let row = self.row == 0 ? 2 : self.row == 2 ? 0 : 1
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
    static func getBox(row: Int, col: Int) -> GridBox {
        let result = allCases.compactMap({ $0.row == row && $0.col == col ? $0 : nil})
        if result.count == 1 {
            return result[0]
        }
        return .box00
    }
}
