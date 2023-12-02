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

enum UserDefaultsKey: String {
  case isFirstLaunch = "isFirstLaunch"
  case userName = "userName"
  case userAdress = "userAddress"
  case userCountry = "userCountry"
}

enum UserCountryError: Error {
  case countryNotFound
}

enum UserCountry: String {
  case colombia = "MCO"
  case argentina = "MLA"
  
  static func get(userCountry: String) throws -> UserCountry {
    switch userCountry {
    case "MCO": return .colombia
    case "MLA": return .argentina
    default: throw UserCountryError.countryNotFound
    }
  }
}

class Cache {
  static let shared: Cache = Cache()
  private init() {}
  
  var shouldIntroduceUser: Bool {
    get { UserDefaults.standard.bool(forKey: UserDefaultsKey.isFirstLaunch.rawValue )}
    set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.isFirstLaunch.rawValue )}
  }
  
  var userName: String {
    get { UserDefaults.standard.string(forKey: UserDefaultsKey.userName.rawValue) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.userName.rawValue )}
  }
  
  var userAddress: String {
    get { UserDefaults.standard.string(forKey: UserDefaultsKey.userAdress.rawValue) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.userAdress.rawValue )}
  }
  
  var userCountry: String {
    get { UserDefaults.standard.string(forKey: UserDefaultsKey.userCountry.rawValue) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.userCountry.rawValue )}
  }
  
  func saveDefault(forKey key: String, value: Any) -> Any {
    return UserDefaults.standard.set(value, forKey: key)
  }
  
  func getDefault(forKey key: String) -> Any? {
    if let value: Any = UserDefaults.standard.value(forKey: key) {
      return value
    }
    return nil
  }
  
}


struct FirstLaunchView: View {
  @Binding var shouldBeShowing: Bool
  @State private var userName: String = ""
  @State private var userAddres: String = ""
  @State private var userCountry: String = "MCO"
  @State private var countriesList: [String] = ["MCO", "MLA", "MDO", "MCH"]
  
  var body: some View {
    ZStack {
      VStack {
        Form {
          TextField("Ingresa tu nombre completo", text: $userName)
          TextField("Ingresa tu dirección", text: $userAddres)
          Picker("Selecciona tu pais", selection: $userCountry) {
            ForEach(countriesList, id: \.self) { country in
              Text(country)
            }
          }
          .pickerStyle(.menu)
          Button("Finalizar", action: {
            shouldBeShowing = false
            saveValues()
          })
        }
      }
    }
  }
  
  private func saveValues() {
    guard
      !userName.isEmpty,
      !userAddres.isEmpty,
      !userCountry.isEmpty
    else {
      return
    }
    Cache.shared.userName = userName
    Cache.shared.userAddress = userAddres
    Cache.shared.userCountry = userCountry
    Cache.shared.shouldIntroduceUser = false
  }
}
