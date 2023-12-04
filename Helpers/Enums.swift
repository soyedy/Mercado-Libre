//
//  Enums.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 4/12/23.
//

import Foundation

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
