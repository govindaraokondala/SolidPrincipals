//
//  ProdcutsDataSource.swift
//  Solid
//
//  Created by Govind on 28/07/24.
//

import Foundation

protocol AllProductsViewServiceDelegate {
    func loadProducts(completion: @escaping (Result<[Product], ResponseError>) -> Void)
}
protocol TopSellingsProductsViewServiceDelegate {
    func loadTopSellingProducts(completion: @escaping (Result<[Product], ResponseError>) -> Void)
}


protocol ProductsViewServiceDelegate:AllProductsViewServiceDelegate,TopSellingsProductsViewServiceDelegate {
   
}



class ProductsViewNetworkService:ProductsViewServiceDelegate {
    func loadTopSellingProducts(completion: @escaping (Result<[Product], ResponseError>) -> Void) {
        NetworkManager().getRequests( "\(AppConfig.BaseUrl)/topSellingProducts", type: [Product].self, completion: completion)
    }
    
    func loadProducts(completion: @escaping (Result<[Product], ResponseError>) -> Void) {
        NetworkManager().getRequests( "\(AppConfig.BaseUrl)/products", type: [Product].self, completion: completion)
    }
}
class ProductsViewDatabaseService:AllProductsViewServiceDelegate {
    func loadProducts(completion: @escaping (Result<[Product], ResponseError>) -> Void) {
        DatabaseManager().getRequests("Products", "json", type: [Product].self, completion: completion)
    }
}
