//
//  VictoriousLineView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import SwiftUI

// MARK: - The View

struct VictoriousLineView: View {
    
    // MARK: - Environment object
    
    @EnvironmentObject private var gridViewModel: GridViewModel
    
    // MARK: - The line
    
    /// The line to display in the grid.
    private var line: GridLine? {
        if let line = gridViewModel.victoriousLine {
            return line
        } else {
            return nil
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        Group {
            if let line = self.line, let player = gridViewModel.victoriousPlayer {
                ZStack {
                    VictoriousLineShape(line)
                        .opacity(0.5)
                    VictoriousLineShape(line)
                        .stroke(lineWidth: CommonProperties.size.getMin(of: 1))
                }
                .foregroundColor(player.color)
                
            }
        }
    }
}

// MARK: - The Shape

fileprivate struct VictoriousLineShape: Shape {
    
    // MARK: - Enum Point
    
    /// Enum used to know which point of the line has be drawn.
    enum Point { case start, end }
    
    // MARK: - The line property
    
    /// The line to display in the grid.
    private let line: GridLine

    // MARK: - Init
    
    init(_ line: GridLine) {
        self.line = line
    }
    
    // MARK: - Path
    
    /**
     Method called to draw the Shape. The rect is the grid's rect.
     */
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let rectPercent = rect.height / 100
        path.move(to: getPoint(point: .start, rectPercent: rectPercent, add: -2))
        path.addLine(to: getPoint(point: .end, rectPercent: rectPercent, add: -2))
        path.addLine(to: getPoint(point: .end, rectPercent: rectPercent, add: 2))
        path.addLine(to: getPoint(point: .start, rectPercent: rectPercent, add: 2))
        path.addLine(to: getPoint(point: .start, rectPercent: rectPercent, add: -2))
        return path
    }
    
    // MARK: - Supporting method
    
    /**
     Compute a CGPoint depending on the needed point (the line's start or end).
     - parameter point: The needed point, .start or .end.
     - parameter rectPercent: 1% of the grid's height or width to compute the point's position in the grid.
     - parameter add: A value to add to the x and/or y point.
     - returns: The computed CGPoint.
     */
    private func getPoint(point: Point, rectPercent: CGFloat, add: CGFloat) -> CGPoint {
        // Initiate x and y
        let x: CGFloat
        let y: CGFloat
        // Get their value depending on the point and on the line
        switch point {
        case .start:
            x = line.startMultipliers.x.cgFloat
            y = line.startMultipliers.y.cgFloat
        case .end:
            x = line.endMultipliers.x.cgFloat
            y = line.endMultipliers.y.cgFloat
        }
        // return the point with the add value
        return CGPoint(
            x: x * rectPercent + (line.addToXMultiplier ? CommonProperties.size.getMin(of: 1) * add : 0),
            y: y * rectPercent + CommonProperties.size.getMin(of: 1) * add
        )
    }
}
