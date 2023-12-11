//
//  OnboardingViewModifiers.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 4/12/23.
//

import Foundation
import SwiftUI

struct FirstLaunchView: View {
  @Binding var shouldBeShowing: Bool
  
  @State private var userName: String = ""
  @State private var userAddress: String = ""
  @State private var userCountry: String = "Colombia"
  
  @State private var invalidInputAlertIsPresented = false
  
  let countriesList: [String] = ["Colombia", "Argentina", "Rep. Domincana", "Chile"]
  
  var body: some View {
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
        
        Button("Finalizar") {
          guard validateFields() else {
            invalidInputAlertIsPresented = true
            return
          }
          
          saveValues()
          Cache.shared.shouldIntroduceUser = false
          UserDefaults.standard.set(false, forKey: UserDefaultsKey.isFirstLaunch.rawValue)
          
          shouldBeShowing = false
        }
        .alert(isPresented: $invalidInputAlertIsPresented) {
          Alert(title: Text("Datos incompletos"), message: Text("Por favor llena todos los datos requeridos"))
        }
      }
    }
  }
  
  private func validateFields() -> Bool {
    return ![userName, userAddress, userCountry].contains(where: { $0.isEmpty })
  }
  
  private func saveValues() {
    Cache.shared.userName = userName
    Cache.shared.userAddress = userAddress
    Cache.shared.userCountry = userCountry
  }
}

