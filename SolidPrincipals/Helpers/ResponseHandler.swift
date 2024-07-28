//
//  ResponseHandler.swift
//  Solid
//
//  Created by Govind on 28/07/24.
//

import Foundation
protocol ResponseHandlerDelegate {
    func getModel<T:Codable>(data:Data,type:T.Type, completion: @escaping (Result<T,ResponseError>) -> Void)
}
class ResponseHandler:ResponseHandlerDelegate {
    func getModel<T:Codable>(data:Data,type:T.Type, completion: @escaping (Result<T,ResponseError>) -> Void) {
        do {
            let resultModel = try JSONDecoder().decode(T.self, from: data)
            completion(.success(resultModel))
        } catch {
            completion(.failure(.errorMessage(ErrorMessages.CommonServer.rawValue)))
        }
    }
}
