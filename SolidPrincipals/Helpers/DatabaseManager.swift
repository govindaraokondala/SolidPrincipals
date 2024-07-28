//
//  DatabaseManager.swift
//  Solid
//
//  Created by Govind on 28/07/24.
//

import Foundation

class DatabaseManager {
    let dbHandler:DatabaseHandler
    let responseHandler:ResponseHandler
    
    init(dbHandler:DatabaseHandler = DatabaseHandler(),
         responseHandler:ResponseHandler = ResponseHandler()) {
        self.dbHandler = dbHandler
        self.responseHandler = responseHandler
    }
    
    func getRequests<T:Codable>(_ fileName:String,_ extensionString:String, type: T.Type, completion: @escaping (Result<T,ResponseError>) -> Void) {
        dbHandler.getData(fileName: fileName, extensionString: extensionString) { result in
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
