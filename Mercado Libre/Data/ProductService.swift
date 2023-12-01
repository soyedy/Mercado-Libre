//
//  ProductService.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import Foundation

protocol Searchable {
  func search(with: String) async throws -> [Product]
}

class ProductService: Searchable, ObservableObject {
  
  func search(with product: String) async throws -> [Product] {
    
    guard let baseUrl: URL = Constants.URLs.search(with: product) else { return [Product]() }
    var request = URLRequest(url: baseUrl)
    request.httpMethod = "GET"
    request.addValue("Bearer ", forHTTPHeaderField: "Authorization")
    
    let (data, _) = try await URLSession.shared.data(for: request)
    let decoder = JSONDecoder()
    let searchResponseDTO = try decoder.decode(ProductDTO.self, from: data)
    let productsList: [Product] = searchResponseDTO.results
    return productsList
  }
}


