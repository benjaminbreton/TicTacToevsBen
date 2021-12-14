//
//  InButton.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import SwiftUI

// MARK: - ViewModifier

fileprivate struct InButton: ViewModifier {
    
    // MARK: - Init properties
    
    private let action: () -> Void
    private let isDisabled: Bool
    
    // MARK: - Init
    
    init(isDisabled: Bool, action: @escaping () -> Void) {
        self.isDisabled = isDisabled
        self.action = action
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        Button(action: action, label: {
            content
        })
        .disabled(isDisabled)
    }
}

// MARK: - View's extension

extension View {
    /**
     Place the view in a button.
     - parameter isDisabled: A boolean indicating whether the button has to be disabled or not, default: false.
     - parameter action: The action to perform when the button is hitten.
     */
    func inButton(isDisabled: Bool = false, action: @escaping () -> Void) -> some View {
        modifier(InButton(isDisabled: isDisabled, action: action))
    }
}
