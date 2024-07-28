//
//  APIHandler.swift
//  Solid
//
//  Created by Govind on 28/07/24.
//

import Foundation
protocol APIHandlerDelegate {
    func getData(url:URL, completion: @escaping (Result<Data,ResponseError>) -> Void)
}

class APIHandler:APIHandlerDelegate {
    func getData(url:URL, completion: @escaping (Result<Data,ResponseError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.errorMessage(ErrorMessages.CommonServer.rawValue)))
                return
            }
            completion(.success(data))
                
        }.resume()
    }
}
