//
//  TestProductsViewModel.swift
//  SolidPrincipalsTests
//
//  Created by E5000539 on 10/08/24.
//

import XCTest
import Combine
@testable import SolidPrincipals

class TestProductsViewModel:XCTestCase {
    var viewModel:ProductsViewModel!
    var mockNetworkService:MockProductsViewNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockProductsViewNetworkService()
        viewModel = ProductsViewModel(networkService: mockNetworkService)
    }
    
    func testLoadProductsFailure() {
        mockNetworkService.result = .failure(.NoDataFound)
        let exception = XCTestExpectation(description: "Fetching products")
        let cancelable:AnyCancellable? = viewModel.$products
            .dropFirst()
            .sink { values in
                exception.fulfill()
            }
        viewModel.fetchProducts()
        wait(for: [exception], timeout: 2.0)
        
        XCTAssertTrue(viewModel.hasError)
        cancelable?.cancel()
    }
    
    func testLoadProductsSuccess() {
        let result = LoadDataFromLocalFiles().getData(fileName: "SampleProducts", extensionString: "json", type: Products.self)
        mockNetworkService.result = result
        
        let exception = XCTestExpectation(description: "Fetching products")
        let cancelable:AnyCancellable? = viewModel.$products
            .dropFirst()
            .sink { values in
                exception.fulfill()
            }
        viewModel.fetchProducts()
        wait(for: [exception], timeout: 2.0)
        XCTAssertFalse(viewModel.products.isEmpty)
        cancelable?.cancel()
    }
    
}
