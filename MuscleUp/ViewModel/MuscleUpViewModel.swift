//
//  MuscleUpViewModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 16/03/2024.
//

import Foundation

class MuscleUpViewModel: ObservableObject, ErrorHandler {
    func showErrorToast(message: String) {
        NotificationCenter.default.post(name: Notification.Name("ShowToastNotification"), object: message)
    }
}
