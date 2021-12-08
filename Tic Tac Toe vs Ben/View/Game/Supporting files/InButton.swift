//
//  InButton.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

fileprivate struct InButton: ViewModifier {
    private let action: () -> Void
    private let isDisabled: Bool
    init(isDisabled: Bool, action: @escaping () -> Void) {
        self.isDisabled = isDisabled
        self.action = action
    }
    func body(content: Content) -> some View {
        Button(action: action, label: {
            content
        })
        .disabled(isDisabled)
    }
}
extension View {
    func inButton(isDisabled: Bool = false, action: @escaping () -> Void) -> some View {
        modifier(InButton(isDisabled: isDisabled, action: action))
    }
}
