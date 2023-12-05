//
//  Cache.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 4/12/23.
//

import Foundation

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
