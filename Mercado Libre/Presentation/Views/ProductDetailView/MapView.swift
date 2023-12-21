//
//  MapView.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 21/12/23.
//

import Foundation
import MapKit
import SwiftUI

class Location: NSObject, MKAnnotation {
  let title: String?
  let coordinate: CLLocationCoordinate2D
  
  init(title: String?, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.coordinate = coordinate
  }
}

struct MapViewRepresentable: UIViewRepresentable {
  let latitude: Double
  let longitude: Double
  
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    uiView.setCenter(coordinate, animated: true)
    
    let location = Location(title: nil, coordinate: coordinate)
    uiView.addAnnotation(location)
  }
}

