//
//  ProductService.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import Foundation

enum ServiceError: Error {
  case serviceFailedFetching
  case noResultsFound
  case invalidUrlRequest
  case internalError
}

protocol Searchable: ObservableObject {
  func search(with query: String) async throws -> [Product]
}

class ProductService: Searchable {
  
  private func fetchProducts(from url: URL) async throws -> [Product] {
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("Bearer YOUR_TOKEN_HERE", forHTTPHeaderField: "Authorization")
    
    do {
      let (data, _) = try await URLSession.shared.data(for: request)
      let decoder = JSONDecoder()
      
      let searchResponseDTO = try decoder.decode(SearchResult.self, from: data)
      
      if let products: [Product] = searchResponseDTO.results {
        return products
      } else {
        throw ServiceError.internalError
      }
    } catch {
      throw ServiceError.serviceFailedFetching
    }
  }
  
  func search(with productName: String) async throws -> [Product] {
    guard let baseURL = try? Constants.URLs.search(with: productName) else {
      throw ServiceError.invalidUrlRequest
    }
    return try await fetchProducts(from: baseURL)
  }
  
  func welcomeProducts() async throws -> [Product] {
    guard let baseURL = try? Constants.URLs.welcomeProducts() else {
      throw ServiceError.invalidUrlRequest
    }
    return try await fetchProducts(from: baseURL)
  }
}
