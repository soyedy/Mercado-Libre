//
//  ViewModel.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 9/12/23.
//

import Foundation
import CoreLocation

protocol ProductViewModelProtocol: ObservableObject {
  var productList: [Product] { get set }
  var isLoading: Bool { get set }
  func fetchProducts(withName name: String) async throws
  func fetchWelcomeProducts() async throws
}

final class ProductViewModel: ProductViewModelProtocol {
  private var useCases: ProductUseCases
  var localizable: ProductLocalizables
  @Published var productList: [Product] = [Product]()
  @Published var isLoading: Bool = false
  
  var locationManager = LocationManager()
  
  init(usesCases: ProductUseCases, localizable: ProductLocalizables) {
    self.useCases = usesCases
    self.localizable = localizable
  }
  
  @MainActor
  func fetchProducts(withName name: String) async throws {
    isLoading = true
    defer { isLoading = false }
    
    let productsList: [Product] = try await useCases.fetchProductUseCase.execute(name: name)
    self.productList = productsList
  }
  
  @MainActor
  func fetchWelcomeProducts() async throws {
    isLoading = true
    defer { isLoading = false }
    
    let productList: [Product] = try await useCases.welcomeProductUseCase.execute()
    self.productList = productList
  }
  
  func requestLocationServices() {
    locationManager.requestLocation()
  }
  
}

class LocationManager: NSObject, CLLocationManagerDelegate {
  private var locationManager: CLLocationManager
  
  init(with manager: CLLocationManager = CLLocationManager()) {
    self.locationManager = manager
    super.init()
    self.locationManager.delegate = self
  }
  
  func requestLocation() {
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      print("Location received: \(location)")
      geocode(location: location)
    }
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
    case .authorizedAlways, .authorizedWhenInUse:
      if let location = manager.location {
        geocode(location: location)
      }
    case .denied:
      print("User has denied location services.")
    case .restricted:
      print("Location services are restricted.")
    default:
      break
    }
  }
  
  func geocode(location: CLLocation) {
    let geocoder = CLGeocoder()
    
    if !geocoder.isGeocoding {
      geocoder.reverseGeocodeLocation(location) { placemarks, error in
        if let error = error {
          print("Geocoding error: \(error)")
          return
        }
        
        if let country = placemarks?.first?.country {
          print("Country: \(country)")
          
        }
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Failed to get location: \(error.localizedDescription)")
  }
}
