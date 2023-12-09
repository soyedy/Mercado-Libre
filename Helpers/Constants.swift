//
//  Constants.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 30/11/23.
//

import Foundation

enum URLBuildingError: Error {
  case invalidURL
}

struct Constants {
  static let defaultTitleSize = 18
  static let defaultBodyTextSize = 14
  
  struct URLs {
    static let baseURL = URL(string: "https://api.mercadolibre.com/")!
    
    enum SiteId: String {
      case MLA = "MLA"
      case MCO = "MCO"
    }
    
    static func search(with product: String) throws -> URL {
      var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
      components.path = "/sites/\(SiteId.MCO.rawValue)/search"
      components.queryItems = [
        URLQueryItem(name: "q", value: product)
      ]
      
      guard let url = components.url else {
        throw URLBuildingError.invalidURL
      }
      return url
    }
    
    static func welcomeProducts() throws -> URL {
      var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
      components.path = "/sites/\(SiteId.MCO.rawValue)/search"
      components.queryItems = [
        URLQueryItem(name: "category", value: "MCO1055")
      ]
      
      guard let url = components.url else {
        throw URLBuildingError.invalidURL
      }
      return url
    }
  }
}
