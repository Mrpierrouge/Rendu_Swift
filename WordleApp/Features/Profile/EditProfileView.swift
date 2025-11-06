//
//  EditProfileView.swift
//  WordleApp
//
//  Created by LETARD Pierric on 06/11/2025.
//

import PhotosUI
import SwiftUI

struct EditProfileView: View {
    @Bindable var user: UserProfileModel
    @State var selectedItem: PhotosPickerItem? = nil
    @State var showPhotoPicker = false
    
    var body: some View {
        Form {
            Section {
                VStack {
                    if let image = user.avatarImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    } else {
                        Circle()
                            .fill(.gray.opacity(0.3))
                            .frame(width: 120, height: 120)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 50))
                                    .foregroundStyle(.gray)
                            )
                    }
                }
                Button("Changer la photo") {
                    showPhotoPicker = true
                }
                .buttonStyle(.borderedProminent)
                .photosPicker(
                    isPresented: $showPhotoPicker,
                    selection: $selectedItem,
                    matching: .images
                )
            }
            Section {
                TextField("Nom d'utilisateur", text: $user.username)
            }
        }
        .navigationTitle("Modifier le profil")
        .onChange(of: selectedItem) {
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    user.avatarImage = uiImage
                }
            }
        }
        
    }
    
}

