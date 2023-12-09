//
//  ViewModel.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 9/12/23.
//

import Foundation

protocol ProductViewModelProtocol: ObservableObject {
  var productList: [Product] { get set }
  var isLoading: Bool { get set }
  func fetchProducts(withName name: String) async throws
  func fetchWelcomeProducts() async throws
}

final class ProductViewModel: ProductViewModelProtocol {
  private var useCases: ProductUseCases
  var localizable: ProductLocalizables
  @Published var productList: [Product] = [Product]()
  @Published var isLoading: Bool = false
  
  init(usesCases: ProductUseCases, localizable: ProductLocalizables) {
    self.useCases = usesCases
    self.localizable = localizable
  }
  
  @MainActor
  func fetchProducts(withName name: String) async throws {
    isLoading = true
    defer { isLoading = false }
    
    let productsList: [Product] = try await useCases.fetchProductUseCase.execute(name: name)
    self.productList = productsList
  }
  
  @MainActor
  func fetchWelcomeProducts() async throws {
    isLoading = true
    defer { isLoading = false }
    
    let productList: [Product] = try await useCases.welcomeProductUseCase.execute()
    self.productList = productList
  }
}
