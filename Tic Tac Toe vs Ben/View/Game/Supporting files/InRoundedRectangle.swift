//
//  InRoundedRectangle.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import SwiftUI

fileprivate struct InRoundedRectangle: ViewModifier {
    private let color: Color
    private let paddingValue: CGFloat
    init(color: Color, padding: Bool) {
        self.color = color
        paddingValue = padding ? CommonProperties.size.getMin(of: 3) : 0
    }
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle()
                .opacity(0.3)
            content
                .padding(paddingValue)
            RoundedRectangle()
                .stroke()
        }
        .foregroundColor(color)
    }
}
extension View {
    func inRoundedRectangle(color: Color = .appBlack, padding: Bool = true) -> some View {
        modifier(InRoundedRectangle(color: color, padding: padding))
    }
}
