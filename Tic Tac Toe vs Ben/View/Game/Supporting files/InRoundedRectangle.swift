//
//  InRoundedRectangle.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import SwiftUI

// MARK: - ViewModifier

fileprivate struct InRoundedRectangle: ViewModifier {
    
    // MARK: - Init properties
    
    private let color: Color
    private let paddingValue: CGFloat
    
    // MARK: - Init
    
    init(color: Color, padding: Bool) {
        self.color = color
        paddingValue = padding ? CommonProperties.size.getMin(of: 3) : 0
    }
    
    // MARK: - Body
    
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

// MARK: - View's extension

extension View {
    /**
     Place the view in a rounded rectangle frame.
     - parameter color: The color of the view, default: .appBlack.
     - parameter padding: A boolean indicating whether a padding has to be applied to the view inside the rectangle or not, default: true.
     - returns: The computed view.
     */
    func inRoundedRectangle(color: Color = .appBlack, padding: Bool = true) -> some View {
        modifier(InRoundedRectangle(color: color, padding: padding))
    }
}
