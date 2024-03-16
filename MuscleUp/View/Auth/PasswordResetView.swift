//
//  PasswordResetView.swift
//  MuscleUp
//
//  Created by Bryan Battu on 19/01/2024.
//

import SwiftUI

struct PasswordResetView: View {
    /// View properties
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    /// Environment properties
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }
            .padding(.top, 10)
        
            HeaderView(title: "Réinitialiser")
            
            VStack(spacing: 25) {
                CustomTextField(autocapitalizationType: .never, sfIcon: "lock", hint: "Mot de passe", isPassword: true, value: $password)
                CustomTextField(autocapitalizationType: .never, sfIcon: "lock", hint: "Confirmer le mot de passe", isPassword: true, value: $confirmPassword)
                    .padding(.top, 5)
                
                GradientButton(title: "Confirmer", icon: "arrow.right") {
                }
                .hSpacing(.trailing)
                // Désactiver tant que les fields ne sont pas remplis
                .disableWithOpacity(password.isEmpty || confirmPassword.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .interactiveDismissDisabled()
    }
}

#Preview {
    ContentView()
}
