//
//  String+Localizable.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 14/12/2021.
//

import Foundation
extension String {
    var localized: String {
        NSLocalizedString(self, comment: .init())
    }
}
