//
//  HeaderView.swift
//  MuscleUp
//
//  Created by Bryan Battu on 19/01/2024.
//

import SwiftUI

struct HeaderView: View {
    public var title: String
    public var subtitle: String?
    
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .padding(.top, 25)
        
        if subtitle != nil {
            Text(subtitle!)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
        }
    }
}

#Preview {
    ContentView()
}
