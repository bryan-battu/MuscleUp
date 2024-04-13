//
//  LoginManager.swift
//  MuscleUp
//
//  Created by Bryan Battu on 28/03/2024.
//

import Foundation
import AuthenticationServices

class LoginManager: NSObject {
    static let shared = LoginManager()
    
    var user: UserModel?
    
    let kStringAccessTokenKey = "kAccessTokenKey"
    
    func getUser() -> UserModel? {
        return user
    }
    
    func setUser(user: UserModel?) {
        self.user = user
    }
    
    func saveAccessToken(accessToken: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(accessToken, forKey: kStringAccessTokenKey)
    }
    
    func getSavedAccessToken() -> String? {
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: kStringAccessTokenKey)
    }
    
    func deleteAccessToken() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: kStringAccessTokenKey)
    }
    
    func actionsLogOut() {
        setUser(user: nil)
        deleteAccessToken()
    }
    
    func disconnect() {
        
    }
}