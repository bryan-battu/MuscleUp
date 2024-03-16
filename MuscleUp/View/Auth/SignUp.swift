//
//  SignUp.swift
//  MuscleUp
//
//  Created by Bryan Battu on 14/01/2024.
//

import SwiftUI
import AlertToast

struct SignUp: View {
    @Binding var showSignUp: Bool
    @ObservedObject var authViewModel: AuthViewModel
    
    /// View properties
    @State private var emailID: String = ""
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var password: String = ""
    @State private var confirmedPassword: String = ""
    
    @State private var showToast = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Button {
                showSignUp = false
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }
            .padding(.top, 10)
            
            HeaderView(title: "Inscription", subtitle: "Inscrivez-vous pour continuer")
            
            VStack(spacing: 25) {
                CustomTextField(autocapitalizationType: .never, sfIcon: "at", hint: "Email", value:  $emailID)
                
                CustomTextField(autocapitalizationType: .sentences, sfIcon: "person", hint: "Prénom", value:  $firstname)
                
                CustomTextField(autocapitalizationType: .sentences, sfIcon: "person", hint: "Nom", value:  $lastname)
                
                CustomTextField(autocapitalizationType: .never, sfIcon: "lock", hint: "Mot de passe", isPassword: true, value:  $password)
                
                CustomTextField(autocapitalizationType: .never, sfIcon: "lock", hint: "Confirmez votre mot de passe", isPassword: true, value:  $confirmedPassword)
                
                GradientButton(title: "S'inscrire", icon: "arrow.right") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                    let params: [String : Any] = [
                        "email": emailID,
                        "firstname": firstname,
                        "lastname": lastname,
                        "password": password,
                        "confirmPassword": confirmedPassword
                    ]
                    
                    authViewModel.register(params: params)
                }
                .hSpacing(.trailing)
                // Désactiver tant que les fields ne sont pas remplis
                .disableWithOpacity(emailID.isEmpty || password.isEmpty || firstname.isEmpty || lastname.isEmpty || confirmedPassword.isEmpty)
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ShowToastNotification"))) { notification in
                    guard let message = notification.object as? String else { return }
                    self.showToast = true
                    self.errorMessage = message
                }
                .toast(isPresenting: $showToast) {
                    AlertToast(displayMode: .hud, type: .regular, title: errorMessage)
                }
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6, content: {
                Text("Vous avez déjà un compte ?")
                    .foregroundStyle(.gray)
                
                Button("Connectez-vous") {
                    showSignUp = false
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
    }
}


#Preview {
    ContentView()
}
