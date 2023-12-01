//
//  Constants.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 30/11/23.
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
