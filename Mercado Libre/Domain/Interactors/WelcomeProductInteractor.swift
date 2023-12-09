//
//  WelcomeProductInteractor.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 9/12/23.
//

import Foundation

protocol WelcomeProductUseCase {
  func execute() async throws -> [Product]
}

struct WelcomeProductInteractor: WelcomeProductUseCase {
  let repository: ProductsRepositoryProtocol
  
  init(repository: ProductsRepositoryProtocol) {
    self.repository = repository
  }
  
  func execute() async throws -> [Product] {
    return try await repository.welcomeProducts()
  }
}
