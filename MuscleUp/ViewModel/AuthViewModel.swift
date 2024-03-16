//
//  AuthViewModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 28/02/2024.
//

import Foundation

class AuthViewModel: MuscleUpViewModel {
    var request: Request?
    
    override init() {
        super.init()
        self.request = Request(viewModel: self)
    }
    
    @Published var isLoggedIn = false
    
    func register(params: [String : Any]) {
        guard let request = self.request else {
            return
        }
        
        request.register(params: params) { [self] (response: MuscleUpResponse<RegisterModel>) in
            if let token = response.result?.token {
                UserDefaults.standard.set(token, forKey: "token")
                // Appel de la complétion avec succès
                self.isLoggedIn = true
            } else {
                showErrorToast(message: "Une erreur est survenue")
            }
        }
    }
}
