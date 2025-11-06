//
//  AvatarView.swift
//  WordleApp
//
//  Created by LETARD Pierric on 06/11/2025.
//


import SwiftUI

struct AvatarView: View {
    var image: UIImage?
    var size: CGFloat = 60
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ZStack {
                    Circle().fill(.gray.opacity(0.2))
                    Image(systemName: "person.fill")
                        .foregroundStyle(.gray)
                }
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}
