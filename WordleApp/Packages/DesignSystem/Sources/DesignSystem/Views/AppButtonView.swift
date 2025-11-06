//
//  AppButtonView.swift
//  DesignSystem
//
//  Created by LETARD Pierric on 06/11/2025.
//

import SwiftUI

public struct AppButtonView : View {
    let title: String
    let action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(NSLocalizedString(title, comment: ""))
                .font(.headline)
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(LinearGradient(
                    colors: [Color("blue"), Color("purple")],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .cornerRadius(12)
                .padding(.horizontal, 24)
        }
    }
}
