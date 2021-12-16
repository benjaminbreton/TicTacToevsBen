//
//  CommonProperties.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

final class CommonProperties {
    
    // MARK: - Properties
    
    static let size = Size()
    
    // MARK: - Size
    
    final class Size {
        fileprivate init() { }
        private func getHeight(of percent: CGFloat) -> CGFloat {
            UIScreen.main.bounds.height / 100 * percent
        }
        private func getWidth(of percent: CGFloat) -> CGFloat {
            UIScreen.main.bounds.width / 100 * percent
        }
        func getMin(of percent: CGFloat) -> CGFloat {
            min(getHeight(of: percent), getWidth(of: percent))
        }
        func getMax(of percent: CGFloat) -> CGFloat {
            max(getHeight(of: percent), getWidth(of: percent))
        }
    }
}
