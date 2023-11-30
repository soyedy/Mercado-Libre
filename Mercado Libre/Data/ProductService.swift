//
//  ProductService.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import Foundation


struct Constants {
  static let defaultPageSize = 20
  static let defaultTimeoutInterval = 60.0
  
  enum SiteId: String {
    case MLA = "MLA"
    case MCO = "MCO"
  }
  
  enum URLs: String {
    case baseURL = "https://api.mercadolibre.com/"
    
    
    static func search(with product: String) -> URL? {
      if let searchUrl: URL = URL(string: "\(baseURL.rawValue)sites/\(SiteId.MCO.rawValue)/search?q=\(product)") {
        return searchUrl
      }
      return nil
    }
  }
}

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


