//
//  SignUp.swift
//  MuscleUp
//
//  Created by Bryan Battu on 14/01/2024.
//

import SwiftUI

struct SignUp: View {
    @Binding var showSignUp: Bool
    @ObservedObject var authViewModel: AuthViewModel
    
    /// View properties
    @State private var emailID: String = ""
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var password: String = ""
    @State private var confirmedPassword: String = ""
    
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
                CustomTextField(sfIcon: "at", hint: "Email", value:  $emailID)
                
                CustomTextField(sfIcon: "person", hint: "Prénom", value:  $firstname)
                
                CustomTextField(sfIcon: "person", hint: "Nom", value:  $lastname)
                
                CustomTextField(sfIcon: "lock", hint: "Mot de passe", isPassword: true, value:  $password)
                
                CustomTextField(sfIcon: "lock", hint: "Confirmez votre mot de passe", isPassword: true, value:  $confirmedPassword)
                
                GradientButton(title: "S'inscrire", icon: "arrow.right") {
                    let params: [String : Any] = [
                        "email": emailID,
                        "firstname": firstname,
                        "lastname": lastname,
                        "password": password,
                        "confirmPassword": confirmedPassword
                    ]
                    
                    authViewModel.register(params: params) { result in
                        switch result {
                        case .failure(let error):
                            if let nsError = error as NSError?, let errorMessage = nsError.userInfo[NSLocalizedDescriptionKey] as? String {
                                print(errorMessage)
                            }
                        default: break
                        }
                    }
                }
                .hSpacing(.trailing)
                // Désactiver tant que les fields ne sont pas remplis
                .disableWithOpacity(emailID.isEmpty || password.isEmpty || firstname.isEmpty || lastname.isEmpty || confirmedPassword.isEmpty)
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
                .tint(.appYellow)
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
