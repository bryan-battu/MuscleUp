//
//  GradientButton.swift
//  MuscleUp
//
//  Created by Bryan Battu on 14/01/2024.
//

import SwiftUI

struct GradientButton: View {
    var title: String
    var icon: String
    var onClick: () -> ()
      
    var body: some View {
        Button {
            onClick()
        } label: {
            HStack(spacing: 15, content: {
                Text(title)
                Image(systemName: icon)
            })
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 35)
            .background(LinearGradient(colors: [.cyan, .blue], startPoint: .top, endPoint: .bottom), in: .capsule)
        }
    }
}

#Preview {
    ContentView()
}
