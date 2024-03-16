//
//  MuscleUpResponse.swift
//  MuscleUp
//
//  Created by Bryan Battu on 16/03/2024.
//

import Foundation

class MuscleUpResponse<T: Codable>: Codable {
    var success: Bool
    var errorMessage: String?
    var displayError: Bool?
    let result : T?

    init(success: Bool){
        self.success = success
        self.result = nil
    }
    
    private enum CodingKeys : String, CodingKey {
        case success
        case errorMessage
        case displayError
        case result
    }
}
