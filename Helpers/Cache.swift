//
//  Cache.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 4/12/23.
//

import Foundation

class Cache: ObservableObject {
  static let shared: Cache = Cache()
  private init() {}
  
  @Published var shouldIntroduceUser: Bool = UserDefaults.standard.bool(forKey: UserDefaultsKey.isFirstLaunch.rawValue) {
    didSet {
        UserDefaults.standard.set(shouldIntroduceUser, forKey: UserDefaultsKey.userName.rawValue)
    }
  }
  
  @Published var userName: String = UserDefaults.standard.string(forKey: UserDefaultsKey.userName.rawValue) ?? "" {
    didSet {
        UserDefaults.standard.set(userName, forKey: UserDefaultsKey.userName.rawValue)
    }
  }
  
  @Published var userAddress: String = UserDefaults.standard.string(forKey: UserDefaultsKey.userAdress.rawValue) ?? "" {
    didSet {
        UserDefaults.standard.set(userAddress, forKey: UserDefaultsKey.userAdress.rawValue)
    }
  }
  
  @Published var userCountry: String = UserDefaults.standard.string(forKey: UserDefaultsKey.userCountry.rawValue) ?? "" {
    didSet {
        UserDefaults.standard.set(userCountry, forKey: UserDefaultsKey.userCountry.rawValue)
    }
  }
  
  func saveDefault(forKey key: String, value: Any) {
    return UserDefaults.standard.set(value, forKey: key)
  }
  
  func getDefault(forKey key: String) -> Any? {
    if let value: Any = UserDefaults.standard.value(forKey: key) {
      return value
    }
    return nil
  }
  
}
