//
//  Font+appFont.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import SwiftUI

extension Font {
    static var appRegular: Font { getFont() }
    static var appTitle: Font { getFont(size: 2) }
    static private func getFont(name: String = "Marker Felt", size: CGFloat = 1) -> Font {
        Font.custom(name, size: CommonProperties.shared.getMin(of: 5))
    }
}
