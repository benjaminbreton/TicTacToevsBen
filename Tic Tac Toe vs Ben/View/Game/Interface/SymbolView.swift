//
//  SymbolView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

struct SymbolView: View {
    
    private let symbol: String
    private var size: CGFloat { CommonProperties.shared.getHeight(of: 2) }
    init(_ symbol: String) {
        self.symbol = symbol
    }
    var body: some View {
        Group {
            if symbol == "x" {
                ZStack {
                    RoundedRectangle()
                        .frame(height: size)
                        .rotationEffect(.degrees(45))
                    RoundedRectangle()
                        .frame(height: size)
                        .rotationEffect(.degrees(-45))
                }
                .foregroundColor(.appRed)
            } else if symbol == "o" {
                Circle()
                    .stroke(lineWidth: size)
                    .foregroundColor(.appGreen)
            }
        }
        .padding()
        
    }
}
