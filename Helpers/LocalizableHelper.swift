//
//  LocalizableHelper.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 30/11/23.
//

import Foundation

struct ProductLocalizables {
  
  var productViewTitle: String {
    return "ProductViewTitle".Localized(comment: "Product view title")
  }
  
  var searchTextfieldTitle: String {
    return "SearchTextfieldTitle".Localized(comment: "Placeholder for search in product list")
  }
}
