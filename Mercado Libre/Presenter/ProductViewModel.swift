//
//  ProductPresenterViewModelProtocol.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import Foundation

@MainActor
protocol ProductViewModelProtocol {
  var localizable: ProductLocalizables { get }
  var productList: [Product] { get set }
  func fetchProducts(withName name: String) async throws
}

final class ProductViewModel: ProductViewModelProtocol, ObservableObject {
  var localizable: ProductLocalizables
  var productService: ProductService
  @Published var productList: [Product] = [Product]()
  
  init(localizable: ProductLocalizables, fetchProductService: ProductService) {
    self.localizable = localizable
    self.productService = fetchProductService
  }
  
  func fetchProducts(withName name: String) async throws {
    let productsList: [Product] = try await productService.search(with: name)
    self.productList = productsList
  }
}

