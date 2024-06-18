//
//  SessionDetail.swift
//  MuscleUp
//
//  Created by Bryan Battu on 10/04/2024.
//

import SwiftUI
import RealmSwift

struct SessionDetail: View {
    @ObservedRealmObject var session: SessionRealmModel
    var exerciceViewModel = ExerciceViewModel()
    var sessionViewModel = SessionViewModel()
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            HStack {
                GradientButton(title: "Annuler", little: true, danger: true) {
                    
                }
                
                Spacer()
                
                GradientButton(title: "Terminer", little: true) {
                    sessionViewModel.completeSeance()
                }
            }
            .padding(.horizontal)
            
            
            List(session.exercises, id: \.id) { exercice in
                ExerciceDetail(exercice: exercice)
            }
            .listStyle(PlainListStyle())
            .background(Color.white)
            .listRowInsets(EdgeInsets()) 
            .listRowSeparator(.hidden)
            
            GradientButton(title: "Ajouter un exercice", icon: "dumbbell.fill") {
                showingSheet = true
            }
            .sheet(isPresented: $showingSheet) {
                AddExercice(exerciceViewModel: exerciceViewModel, session: session)
            }
            .padding(.bottom)
            Spacer()
        }
    }
}

#Preview {
    SessionDetail(session: SessionRealmModel())
}
