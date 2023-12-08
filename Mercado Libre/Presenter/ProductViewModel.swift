//
//  ProductPresenterViewModelProtocol.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
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

protocol Repository {
  var localManager: LocalStorageRepository { get }
  var remoteManager: NetworkProductRepository { get }
}

class ProductRepository: Repository {
  var localManager: LocalStorageRepository
  var remoteManager: NetworkProductRepository
  
  init(localManager: LocalStorageRepository,
       remoteManager: NetworkProductRepository) {
    self.localManager = localManager
    self.remoteManager = remoteManager
  }
  
  func getProducts(name: String) async throws -> [Product] {
    let products = try await remoteManager.getProducts(name: name)
    return products
  }
}

@MainActor
protocol ProductViewModelProtocol: ObservableObject {
  var repository: Repository { get }
  var localizable: ProductLocalizables { get }
  var productList: [Product] { get set }
  
  func fetchProducts(withName name: String) async throws
}

final class ProductViewModel: ProductViewModelProtocol {
  var repository: Repository
  var localizable: ProductLocalizables
  @Published var productList: [Product] = [Product]()
  
  init(repository: Repository,
       localizable: ProductLocalizables) {
    self.repository = repository
    self.localizable = localizable
  }
  
  func fetchProducts(withName name: String) async throws {
    let productsList: [Product] = try await repository.remoteManager.getProducts(name: name)
    self.productList = productsList
  }
  
  func welcomeProducts() async throws {
    let productList: [Product] = try await repository.remoteManager.welcomeProducts()
    self.productList = productList
  }
  
}

