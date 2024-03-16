//
//  Request.swift
//  MuscleUp
//
//  Created by Bryan Battu on 28/02/2024.
//

import Foundation
import Alamofire

protocol ErrorHandler: AnyObject {
    func showErrorToast(message: String)
}

class Request {
    
    let viewModel: any ErrorHandler
    
    init(viewModel: any ErrorHandler) {
        self.viewModel = viewModel
    }
    
    let urlMuscleUp = "https://thomasdubuis.alwaysdata.net/api/v1.0"
    
    let endPointRegister = "/auth/register"
    
    func register<T : Codable>(params : [String : Any], completion: @escaping (MuscleUpResponse<T>) -> ()){
        postMethod(params: params, endpoint: endPointRegister, completion: completion)
    }
    
    func postMethod<T : Codable>(params : Parameters, endpoint : String, completion: @escaping (MuscleUpResponse<T>) -> ()) {
        let url = urlMuscleUp + endpoint

        var headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any?] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                    }
                    
                    print("⬅️ Response \(endpoint): \(prettyPrintedJson)")
                    
                    let r1 = Data("\(prettyPrintedJson)".utf8)
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MuscleUpResponse<T>.self, from: r1)
                    
                    //DISPLAY ERROR
                    if !response.success {
                        if (response.displayError != nil) && (response.displayError == true) {
                            if let message = response.errorMessage {
                                self.viewModel.showErrorToast(message: message)
                            } else {
                                self.viewModel.showErrorToast(message: "Une erreur est survenue")
                            }
                        } else {
                            self.viewModel.showErrorToast(message: "Une erreur est survenue")
                        }
                    } else {
                        completion(response)
                    }
                } catch {
                    self.viewModel.showErrorToast(message: "Une erreur est survenue")
                    return
                }
            case .failure(let error):
                self.viewModel.showErrorToast(message: "Une erreur est survenue")
                return
            }
        }
    }
}
