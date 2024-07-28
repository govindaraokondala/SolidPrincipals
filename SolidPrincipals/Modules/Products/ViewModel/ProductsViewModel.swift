//
//  ProductsViewModel.swift
//  Solid
//
//  Created by Govind on 28/07/24.
//

import Foundation

class ProductsViewModel:ObservableObject {
    let networkService:ProductsViewServiceDelegate
    let databaseService:AllProductsViewServiceDelegate
    @Published var products = [Product]()
    @Published var errorMessage = ""
    @Published var hasError = false
    @Published var isLoading = false
    
    init(networkService:ProductsViewServiceDelegate = ProductsViewNetworkService(),
         databaseService:AllProductsViewServiceDelegate = ProductsViewDatabaseService()) {
        self.networkService = networkService
        self.databaseService = databaseService
    }
    
    func fetchProducts() {
        hasError = false
        isLoading = true
        if isNetworkConnected() {
            networkService.loadProducts {[weak self] result in
                guard let self else {
                    return
                }
                self.handleResult(result: result)
            }
        } else {
            databaseService.loadProducts {[weak self] result in
                guard let self else {
                    return
                }
                self.handleResult(result: result)
            }
        }
    }
    private func handleResult(result:Result<[Product], ResponseError>) {
        DispatchQueue.main.async {[weak self] in
            guard let self else {
                return
            }
            self.isLoading = false
            switch result {
            case .success(let prodcuts):
                self.products = prodcuts
            case .failure(let error):
                self.products = []
                self.errorMessage = error.localizedDescription
                self.hasError = true
            }
            
        }
    }
    
    func isNetworkConnected() -> Bool {
        // Currently, I'm assuming true, but in a real scenario, we would typically use a Reachability class to check internet availability.
        true
    }
}