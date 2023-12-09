//
//  FetchProductInteractor.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 9/12/23.
//

import Foundation

protocol FetchProductUseCase {
  func execute(name: String) async throws -> [Product]
}

struct FetchProductInteractor: FetchProductUseCase {
  let repository: ProductsRepositoryProtocol
  
  init(repository: ProductsRepositoryProtocol) {
    self.repository = repository
  }
  
  func execute(name: String) async throws -> [Product] {
    return try await repository.getProducts(name: name)
  }
}
