//
//  ForgotPassword.swift
//  MuscleUp
//
//  Created by Bryan Battu on 14/01/2024.
//

import SwiftUI

struct ForgotPassword: View {
    @Binding var showResetView: Bool
    /// View properties
    @State private var emailID: String = ""
    /// Environment properties
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }
            .padding(.top, 10)
        
            HeaderView(title: "Mot de passe oublié", subtitle: "Indiquez votre email")
            
            VStack(spacing: 25) {
                CustomTextField(autocapitalizationType: .never, sfIcon: "at", hint: "Email", value:  $emailID)
                
                GradientButton(title: "Envoyer le lien ", icon: "arrow.right") {
                    Task {
                        dismiss()
                        try? await Task.sleep(for: .seconds(0))
                        showResetView = true
                    }
                }
                .hSpacing(.trailing)
                // Désactiver tant que les fields ne sont pas remplis
                .disableWithOpacity(emailID.isEmpty)
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
