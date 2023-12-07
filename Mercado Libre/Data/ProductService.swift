//
//  ProductService.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import Foundation

enum ServiceError: Error {
  case serviceFailedFetching
  case invalidUrlRequest
  case internalError
}

protocol Searchable: ObservableObject {
  func search(with query: String) async throws -> [Product]
}

class ProductService: Searchable {
  @Published var isLoading = false
  
  func search(with query: String) async throws -> [Product] {
    guard let baseURL = Constants.URLs.search(with: query.lowercased()) else {
      throw ServiceError.invalidUrlRequest
    }
    var request = URLRequest(url: baseURL)
    request.httpMethod = "GET"
    request.addValue("Bearer YOUR_TOKEN_HERE", forHTTPHeaderField: "Authorization")
    
    isLoading = true
    defer { isLoading = false }
    
    do {
      let (data, _) = try await URLSession.shared.data(for: request)
      let decoder = JSONDecoder()
      
      let searchResponseDTO = try? decoder.decode(ProductDTO.self, from: data)
      if let products: [Product] = searchResponseDTO?.results {
        return products
      } else {
        throw ServiceError.internalError
      }
    } catch {
      throw ServiceError.serviceFailedFetching
    }
  }
}
