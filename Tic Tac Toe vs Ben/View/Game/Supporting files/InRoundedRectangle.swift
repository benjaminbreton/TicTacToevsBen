//
//  InRoundedRectangle.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import SwiftUI

fileprivate struct InRoundedRectangle: ViewModifier {
    private let color: Color
    init(color: Color) {
        self.color = color
    }
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle()
                .opacity(0.3)
            content
                .padding()
            RoundedRectangle()
                .stroke()
        }
        .foregroundColor(color)
    }
}
extension View {
    func inRoundedRectangle(color: Color = .appBlack) -> some View {
        modifier(InRoundedRectangle(color: color))
    }
}
