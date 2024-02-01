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
    
    var body: some View {
        NavigationStack {
            Login(showSignUp: $showSignUp)
                .navigationDestination(isPresented: $showSignUp) {
                    SignUp(showSignUp: $showSignUp)
                }
        }
        .overlay {
            if #available(iOS 17, *) {
                circleView()
                    .animation(.smooth(duration: 0.45, extraBounce:  0), value: showSignUp)
            } else {
                circleView()
                    .animation(.easeInOut(duration: 0.3), value: showSignUp)
            }
        }
    }
    
    // On fait un cercle dont la position va changer en fonction de si on est sur l'écran de connexion ou d'inscription
    @ViewBuilder
    func circleView() -> some View {
        Circle()
            .fill(.linearGradient(colors: [.appYellow, .orange, .red ], startPoint: .top, endPoint: .bottom))
            .frame(width: 200, height: 200)
            /// Moving when the SignUp pages loads/dismisses
            .offset(x: showSignUp ? 90 : -90, y: -90)
            .blur(radius: 15)
            .hSpacing(showSignUp ? .trailing : .leading)
            .vSpacing(.top)
    }
}

#Preview {
    ContentView()
}
