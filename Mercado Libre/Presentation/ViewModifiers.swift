//
//  ViewModifiers.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 30/11/23.
//

import SwiftUI
import Foundation

struct FirstLaunchView: View {
  @Binding var shouldBeShowing: Bool
  @State private var userName: String = ""
  @State private var userAddress: String = ""
  @State private var userCountry: String = "MCO"
  @State private var countriesList: [String] = ["MCO", "MLA", "MDO", "MCH"]
  
  var body: some View {
    ZStack {
      VStack {
        Form {
          TextField("Ingresa tu nombre completo", text: $userName)
          TextField("Ingresa tu dirección", text: $userAddress)
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
      !userAddress.isEmpty,
      !userCountry.isEmpty
    else {
      return
    }
    Cache.shared.userName = userName
    Cache.shared.userAddress = userAddress
    Cache.shared.userCountry = userCountry
    Cache.shared.shouldIntroduceUser = false
  }
}




