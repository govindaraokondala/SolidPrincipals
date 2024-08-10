//
//  LoadLocalJsonData.swift
//  SolidPrincipalsTests
//
//  Created by E5000539 on 10/08/24.
//

import Foundation
@testable import SolidPrincipals

class LoadDataFromLocalFiles {
    func getData<T:Codable>(fileName:String, extensionString:String, type:T.Type) -> Result<T,ResponseError> {
        guard let url = Bundle(for: LoadDataFromLocalFiles.self).url(forResource: fileName, withExtension: extensionString),
                let data = try? Data(contentsOf: url) else {
            return .failure(.NoDataFound)
        }
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return .success(result)
        } catch {
            return .failure(.NoDataFound)
        }
    }
}
