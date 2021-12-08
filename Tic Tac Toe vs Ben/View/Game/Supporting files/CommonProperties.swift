//
//  CommonProperties.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

class CommonProperties {
    static let shared = CommonProperties()
    private init() { }
    func getHeight(of percent: CGFloat) -> CGFloat {
        UIScreen.main.bounds.height / 100 * percent
    }
    func getWidth(of percent: CGFloat) -> CGFloat {
        UIScreen.main.bounds.width / 100 * percent
    }
    func getMin(of percent: CGFloat) -> CGFloat {
        min(getHeight(of: percent), getWidth(of: percent))
    }
}
