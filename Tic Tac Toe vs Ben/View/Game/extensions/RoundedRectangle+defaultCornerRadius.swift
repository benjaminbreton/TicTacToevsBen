//
//  RoundedRectangle+defaultCornerRadius.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

extension RoundedRectangle {
    init() {
        self.init(cornerRadius: CommonProperties.size.getMin(of: 2))
    }
}
