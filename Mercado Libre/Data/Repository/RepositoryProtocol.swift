//
//  RepositoryProtocols.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 9/12/23.
//

import Foundation

protocol ProductsRepositoryProtocol {
  var localManager: LocalStorageRepository { get }
  var remoteManager: NetworkProductRepository { get }
  
  func getProducts(name: String) async throws -> [Product]
  func welcomeProducts() async throws -> [Product]
}

struct ProductRepository: ProductsRepositoryProtocol {
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
