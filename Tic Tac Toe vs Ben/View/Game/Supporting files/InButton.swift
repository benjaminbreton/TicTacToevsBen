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
    private let id: String
    
    // MARK: - Init
    
    init(isDisabled: Bool, id: String, action: @escaping () -> Void) {
        self.isDisabled = isDisabled
        self.action = action
        self.id = id
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        Button(action: action, label: {
            content
        })
        .disabled(isDisabled)
        .accessibility(identifier: id)
    }
}

// MARK: - View's extension

extension View {
    /**
     Place the view in a button.
     - parameter id: The button's id.
     - parameter isDisabled: A boolean indicating whether the button has to be disabled or not, default: false.
     - parameter action: The action to perform when the button is hitten.
     */
    func inButton(_ id: String, isDisabled: Bool = false, action: @escaping () -> Void) -> some View {
        modifier(InButton(isDisabled: isDisabled, id: id, action: action))
    }
}
