//
//  VictoriousLineView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import SwiftUI

struct VictoriousLineView: View {
    @EnvironmentObject private var gridViewModel: GridViewModel
    private var line: GridLine? {
        if let line = gridViewModel.victoriousLine {
            print("ok")
            return line
        } else {
            return nil
        }
    }
    var body: some View {
        Group {
            if let line = self.line, let player = gridViewModel.victoriousPlayer {
                ZStack {
                    VictoriousLineShape(line)
                        .opacity(0.5)
                    VictoriousLineShape(line)
                        .stroke(lineWidth: CommonProperties.shared.getMin(of: 1))
                }
                .foregroundColor(Color(player.colorName))
                
            }
        }
    }
}
fileprivate struct VictoriousLineShape: Shape {
    private let line: GridLine
    init(_ line: GridLine) {
        self.line = line
    }
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
    
    func getPoint(point: Point, rectPercent: CGFloat, add: CGFloat) -> CGPoint {
        let x: CGFloat
        let y: CGFloat
        
        switch point {
        case .start:
            x = line.startMultipliers.x.cgFloat
            y = line.startMultipliers.y.cgFloat
        case .end:
            x = line.endMultipliers.x.cgFloat
            y = line.endMultipliers.y.cgFloat
        }
        return CGPoint(
            x: x * rectPercent + (line.addToXMultiplier ? CommonProperties.shared.getMin(of: 1) * add : 0),
            y: y * rectPercent + CommonProperties.shared.getMin(of: 1) * add
        )
    }
    
    enum Point { case start, end }
    
}
