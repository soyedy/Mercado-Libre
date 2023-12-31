//
//  Mercado_LibreApp.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import SwiftUI
import CoreData

@main
struct Mercado_LibreApp: App {
  @State private var shouldIntroduceUser: Bool =
  Cache.shared.getDefault(forKey: UserDefaultsKey.isFirstLaunch.rawValue) as? Bool ?? true
  @State private var selectedTab: TabBarItem = .home
  let repository: ProductRepository =
  ProductRepository(
    localManager: LocalStorageRepository(container: NSPersistentContainer(name: "")),
    remoteManager: NetworkProductRepository(service: ProductService()))
  
  var body: some Scene {
    WindowGroup {
      let productViewModel: ProductViewModel =
      ProductViewModel(
        usesCases:
          ProductUseCasesImplementation(
            fetchProductUseCase: FetchProductInteractor(repository: repository),
            welcomeProductUseCase: WelcomeProductInteractor(repository: repository)),
        localizable: ProductLocalizables()
      )
      
      TabView(selection: $selectedTab) {
        HomeView(viewModel: productViewModel, selectedTabBar: $selectedTab)
          .tabItem {
            Image(systemName: "house")
            Text("Inicio")
          }
          .tag(TabBarItem.home)
          .sheet(isPresented: $shouldIntroduceUser) {
            FirstLaunchView(shouldBeShowing: $shouldIntroduceUser)
          }
        
        Text("Favoritos")
          .tabItem {
            Image(systemName: "heart")
            Text("Favoritos")
          }
          .tag(TabBarItem.favourite)
        
        Text("Mis compras")
          .tabItem {
            Image(systemName: "bag")
            Text("Mis compras")
          }
          .tag(TabBarItem.purchase)
        
        Text("Notificaciones")
          .tabItem {
            Image(systemName: "bell")
            Text("Notificaciones")
          }
          .tag(TabBarItem.notifications)
        
        Text("Más")
          .tabItem {
            Image(systemName: "line.3.horizontal")
            Text("Más")
          }
          .tag(TabBarItem.settings)
      }
    }
  }
}
