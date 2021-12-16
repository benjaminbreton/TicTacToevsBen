//
//  TitleView.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 14/12/2021.
//

import SwiftUI

struct TitleView: View {
    
    // MARK: - Init property
    
    private let isHidden: Bool
    
    // MARK: - Init
    
    init(isHidden: Bool = false) {
        self.isHidden = isHidden
    }
    
    // MARK: - Body
    
    var body: some View {
        Group {
            if !isHidden {
                Text("Tic Tac Toe vs Ben")
                    .font(.appTitle)
                    .inRoundedRectangle()
                    .frame(height: CommonProperties.size.getMin(of: 10))
                    .padding()
                    .accessibility(identifier: "title")
            }
        }
    }
}
