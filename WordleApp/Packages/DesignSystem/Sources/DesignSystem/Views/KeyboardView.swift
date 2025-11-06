//
//  KeyboardView.swift
//  DesignSystem
//
//  Created by LETARD Pierric on 05/11/2025.
//

import SwiftUI

public struct KeyboardView: View {
    public init(keys: [[KeyboardKey]], action: @escaping (KeyboardKey) -> Void) {
        self.keys = keys
        self.action = action
    }
    let action: (KeyboardKey) -> Void
    let keys: [[KeyboardKey]]

    public var body: some View {
        VStack(spacing: 8) {
            ForEach(keys.indices, id: \.self) { rowIndex in
                HStack(spacing: 6) {
                    ForEach(keys[rowIndex]) { key in
                        KeyboardKeyView(key: key, size: 32, action: action)
                            .fixedSize()
                    }
                }
                .frame(maxWidth: .infinity)

            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
    }
}
