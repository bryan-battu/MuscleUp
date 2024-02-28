//
//  AuthViewModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 28/02/2024.
//

import Foundation

class AuthViewModel: ObservableObject {
    let request = Request()
    
    @Published var isLoggedIn = false
    
    func register(params: [String : Any], completion: @escaping (Result<String, Error>)->Void) {
        request.register(params: params) { (result: Result<RegisterModel, Error>) in
            switch result {
            case .success(let response):
                if let token = response.token {
                    // Enregistrement du token dans UserDefaults
                    UserDefaults.standard.set(token, forKey: "token")
                    // Appel de la complétion avec succès
                    self.isLoggedIn = true
                    completion(.success("Register success"))
                } else {
                    if let message = response.message {
                        print(message)
                        completion(.failure(NSError(domain: "AuthViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: message])))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
