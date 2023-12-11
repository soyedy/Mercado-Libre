//
//  ProductServiceProtocol.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 9/12/23.
//

import Foundation
import CoreData

protocol ProductServiceProtocol {
  func getProducts(name: String) -> [Product]?
  func saveProduct(product: Product)
}

class LocalStorageRepository: ProductServiceProtocol {
  let container: NSPersistentContainer
  
  init(container: NSPersistentContainer) {
    self.container = container
  }
  
  func saveProduct(product: Product) {
    
  }
  
  func getProducts(name: String) -> [Product]? {
    return nil
  }
}

class NetworkProductRepository {
  var productService: ProductService
  
  init(service: ProductService) {
    self.productService = service
  }
  
  func getProducts(name: String) async throws -> [Product] {
    return try await productService.search(with: name)
  }
  
  func welcomeProducts() async throws -> [Product] {
    return try await productService.welcomeProducts()
  }
}
