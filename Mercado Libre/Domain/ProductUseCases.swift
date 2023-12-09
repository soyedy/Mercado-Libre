//
//  ProductUseCases.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 9/12/23.
//

import Foundation

protocol ProductUseCases {
  var fetchProductUseCase: FetchProductUseCase { get }
  var welcomeProductUseCase: WelcomeProductUseCase { get }
}

struct ProductUseCasesImplementation: ProductUseCases {
  var fetchProductUseCase: FetchProductUseCase
  var welcomeProductUseCase: WelcomeProductUseCase
  
  init(fetchProductUseCase: FetchProductUseCase,
       welcomeProductUseCase: WelcomeProductUseCase) {
    self.fetchProductUseCase = fetchProductUseCase
    self.welcomeProductUseCase = welcomeProductUseCase
  }
}
