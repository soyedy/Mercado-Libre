//
//  RepositoryProtocols.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 9/12/23.
//

import Foundation

protocol ProductsRepositoryProtocol {
  func getProducts(name: String) async throws -> [Product]
  func welcomeProducts() async throws -> [Product]
}

class ProductRepository: ProductsRepositoryProtocol {
  var localManager: LocalStorageRepository
  var remoteManager: NetworkProductRepository
  
  init(localManager: LocalStorageRepository, remoteManager: NetworkProductRepository) {
    self.localManager = localManager
    self.remoteManager = remoteManager
  }
  
  func getProducts(name: String) async throws -> [Product] {
    let products = try await remoteManager.getProducts(name: name)
    return products
  }
  
  func welcomeProducts() async throws -> [Product] {
    return try await remoteManager.welcomeProducts()
  }
}
