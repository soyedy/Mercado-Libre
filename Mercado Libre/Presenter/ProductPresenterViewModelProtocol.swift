//
//  ProductPresenterViewModelProtocol.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import Foundation

@MainActor
protocol ProductPresenterViewModelProtocol {
  var productList: [Product] { get set }
  func fetchProducts(withName name: String) async throws
}

class ProductViewModel: ProductPresenterViewModelProtocol, ObservableObject {
  var productService = ProductService()
  @Published var productList: [Product] = [Product]()
  
  func fetchProducts(withName name: String) async throws {
    let productsList: [Product] = try await productService.search(with: name)
    self.productList = productsList
  }
}
