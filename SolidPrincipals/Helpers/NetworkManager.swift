//
//  NetworkManager.swift
//  Solid
//
//  Created by Govind on 28/07/24.
//

import Foundation

enum ResponseError:Error {
    case BadUrl
    case NoDataFound
    case errorMessage(String)
    
    var localizedDescription: String {
            switch self {
            case .BadUrl:
                return "Invalid URL"
            case .NoDataFound:
                return "No Data found"
            case .errorMessage(let message):
                return "Loading Error: \(message)"
            }
        }
}

enum HTTPMethod:String {
    case get = "GET"
    case post = "POST"
}


class NetworkManager {
    let apiHandler:APIHandlerDelegate
    let responseHandler:ResponseHandlerDelegate
    
    init(apiHandler:APIHandlerDelegate = APIHandler(),
         responseHandler:ResponseHandlerDelegate = ResponseHandler()) {
        self.apiHandler = apiHandler
        self.responseHandler = responseHandler
    }
    
    func getRequests<T:Codable>(_ urlString:String, type: T.Type, completion: @escaping (Result<T,ResponseError>) -> Void) {
        guard let url = URL(string: urlString)   else {
            completion(.failure(.BadUrl))
            return
        }
        apiHandler.getData(url: url) { result in
            switch result {
            case .success(let data):
                self.responseHandler.getModel(data: data, type: T.self) { result in
                    switch result {
                    case .success(let products):
                        completion(.success(products))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
