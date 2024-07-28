//
//  DatabaseHandler.swift
//  Solid
//
//  Created by Govind on 28/07/24.
//

import Foundation
class DatabaseHandler {
    // For now I am loading data from local json file from bundle. In real case we can implement coredata or swift data here.
    func getData(fileName:String, extensionString:String, completion: @escaping (Result<Data,ResponseError>) -> Void) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: extensionString),
                let data = try? Data(contentsOf: url) else {
            return completion(.failure(.errorMessage(ErrorMessages.DBError.rawValue)))
        }
        completion(.success(data))
    }
}
