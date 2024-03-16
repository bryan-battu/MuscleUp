//
//  ContentView.swift
//  MuscleUp
//
//  Created by Bryan Battu on 14/01/2024.
//

import SwiftUI

struct ContentView: View {
    /// View Properties
    @State private var showSignUp: Bool = false
    @ObservedObject var authViewModel = AuthViewModel()
    
    var body: some View {
        ZStack {
            if authViewModel.isLoggedIn {
                Home()
                    .environmentObject(authViewModel)
            } else {
                NavigationStack {
                    Login(showSignUp: $showSignUp)
                        .navigationDestination(isPresented: $showSignUp) {
                            SignUp(showSignUp: $showSignUp, authViewModel: authViewModel)
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
