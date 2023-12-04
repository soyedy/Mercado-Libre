//
//  Mercado_LibreApp.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import SwiftUI

@main
struct Mercado_LibreApp: App {
  @State private var shouldIntroduceUser: Bool = true
  
  var body: some Scene {
    WindowGroup {
      let productViewModel: ProductViewModel =
      ProductViewModel(localizable: ProductLocalizables(),
                       fetchProductService: ProductService()
      )
      
      TabView {
        ProductSearchView(viewModel: productViewModel)
          .tabItem {
            Image(systemName: "house")
            Text("Inicio")
          }
          .sheet(isPresented: $shouldIntroduceUser) {
            FirstLaunchView(shouldBeShowing: $shouldIntroduceUser)
          }
        
        Text("Favoritos")
          .tabItem {
            Image(systemName: "heart")
            Text("Favoritos")
          }
        Text("Mis compras")
          .tabItem {
            Image(systemName: "bag")
            Text("Mis compras")
          }
        Text("Notificaciones")
          .tabItem {
            Image(systemName: "bell")
            Text("Notificaciones")
          }
        Text("Más")
          .tabItem {
            Image(systemName: "line.3.horizontal")
            Text("Más")
          }
      }
    }
  }
}

