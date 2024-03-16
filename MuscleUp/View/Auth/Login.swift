//
//  Login.swift
//  MuscleUp
//
//  Created by Bryan Battu on 14/01/2024.
//

// LOGIN VIEW
 
import SwiftUI

struct Login: View {
    @Binding var showSignUp: Bool
    /// View properties
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var showForgotPasswordView: Bool = false
    @State private var showResetView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Spacer(minLength: 0)
            
            HeaderLogin()
            
            VStack(spacing: 25) {
                CustomTextField(autocapitalizationType: .never, sfIcon: "at", hint: "Email", value:  $emailID)
                
                CustomTextField(autocapitalizationType: .never, sfIcon: "lock", hint: "Mot de passe", isPassword: true, value:  $password)
                
                Button("Mot de passe oublié ?") {
                    showForgotPasswordView.toggle()
                }
                .font(.callout)
                .fontWeight(.heavy)
                .tint(.blue)
                .hSpacing(.trailing)
                
                GradientButton(title: "Se connecter", icon: "arrow.right") {
                    
                }
                .hSpacing(.trailing)
                // Désactiver tant que les fields ne sont pas remplis
                .disableWithOpacity(emailID.isEmpty || password.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6, content: {
                Text("Vous n'avez pas de compte ?")
                    .foregroundStyle(.gray)
                
                Button("Inscrivez-vous") {
                    showSignUp.toggle()
                }
                .fontWeight(.bold)
                .tint(.blue)
            })
            .font(.callout)
            .hSpacing()
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
        /// On demande l'email pour réinitialiser le mot de passe
        .sheet(isPresented: $showForgotPasswordView, content: {
            // On affiche la vue de mot de passe oublié avec une hauteur de 300
            if #available(iOS 16.4, *) {
                ForgotPassword(showResetView: $showResetView)
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            } else {
                ForgotPassword(showResetView: $showResetView)
                    .presentationDetents([.height(300)])
            }
        })
        .sheet(isPresented: $showResetView, content: {
            // On affiche la vue de mot de passe oublié avec une hauteur de 300
            if #available(iOS 16.4, *) {
                PasswordResetView()
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            } else {
                PasswordResetView()
                    .presentationDetents([.height(300)])
            }
        })
    }
}

#Preview {
    ContentView()
}

struct HeaderLogin: View {
    var body: some View {
        Text("Connexion")
            .font(.largeTitle)
            .fontWeight(.heavy)
        
        Text("Connectez-vous pour continuer")
            .font(.callout)
            .fontWeight(.semibold)
            .foregroundStyle(.gray)
            .padding(.top, -5)
    }
}
