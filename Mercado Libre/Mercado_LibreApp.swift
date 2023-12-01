//
//  Mercado_LibreApp.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import SwiftUI

@main
struct Mercado_LibreApp: App {
  var body: some Scene {
    WindowGroup {
      let productViewModel: ProductViewModel =
      ProductViewModel(localizable: ProductLocalizables(),
                       fetchProductService: ProductService()
      )
      ProductSearchView(viewModel: productViewModel)
    }
  }
}
