//
//  MockProductsViewNetworkService.swift
//  SolidPrincipalsTests
//
//  Created by E5000539 on 10/08/24.
//

import Foundation
@testable import SolidPrincipals

class MockProductsViewNetworkService:ProductsViewServiceDelegate {
    
    var result:Result<[Product], ResponseError>?
    var isNetworkAvailable = true
    
    func loadTopSellingProducts(completion: @escaping (Result<[Product], ResponseError>) -> Void) {
        
    }
    
    func loadProducts(completion: @escaping (Result<[Product], ResponseError>) -> Void) {
        guard let result else {
            return
        }
        completion(result)
    }
    
    func isNetworkConnected() -> Bool {
        return isNetworkAvailable
    }
}
