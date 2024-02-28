//
//  Request.swift
//  MuscleUp
//
//  Created by Bryan Battu on 28/02/2024.
//

import Foundation
import Alamofire

class Request {
    let urlMuscleUp = "https://thomasdubuis.alwaysdata.net/api/v1.0"
    
    let endPointRegister = "/auth/register"
    
    func register<T : Codable>(params : [String : Any], completion: @escaping (Result<T, Error>) -> ()){
        postMethod(params: params, endpoint: endPointRegister, completion: completion)
    }
    
    func postMethod<T: Codable>(params: Parameters, endpoint: String, completion: @escaping (Result<T, Error>)->()) {
        let url = urlMuscleUp + endpoint
        
        var headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                guard let httpResponse = response.response else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No HTTP response"])))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode(T.self, from: data)
                    
                    guard 200 ..< 300 ~= httpResponse.statusCode else {
                        completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Unexpected status code: \(httpResponse.statusCode)"])))
                        return
                    }
                    
                    completion(.success(responseObject))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
