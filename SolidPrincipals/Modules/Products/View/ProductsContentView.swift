//
//  ProductsContentView.swift
//  SolidPrincipals
//
//  Created by Govind on 28/07/24.
//

import SwiftUI
import Combine

struct ProductsContentView: View {
    @ObservedObject var viewModel = ProductsViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView {
                        Text("Loading products....")
                    }
                }
                if viewModel.hasError {
                    Text(viewModel.errorMessage)
                        .multilineTextAlignment(.center)
                } else {
                    List(viewModel.products) { product in
                        VStack (alignment: .leading) {
                            Text(product.title ?? "No Title")

                            Text(product.description ?? "No Description")
                                .font(.system(size: 11))
                                .foregroundColor(Color.gray)
                        }
                    }
                    .task {
                        viewModel.fetchProducts()
                    }
                    .listStyle(.plain)
                    .navigationTitle("Products")
                }
            }
        }
        
    }
}


struct ProductsContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsContentView()
    }
}



