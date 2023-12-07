//
//  ProductDetailViewModifiers.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 6/12/23.
//

import Foundation
import SwiftUI

struct ProductDetailView: View {
  var product: Product
  @Binding var selectedTab: TabBarItem
  @State var selectedQuantity: String = "1"
  var quantityArray: [String] {
    guard let availableQuantity = product.availableQuantity else {
      return []
    }
    return Array(1...availableQuantity).map { String($0) }
  }
  
  var body: some View {
    ScrollView {
      VStack(spacing: 10) {
        HStack {
          if let condition: String = product.condition {
            Text(condition == "new" ? "Nuevo " : "")
              .font(.system(size: 11, weight: .bold, design: .rounded))
              .foregroundColor(.gray)
            
            if let salesNumber: Int = product.seller?.sellerReputation?.metrics?.sales?.completed {
              Text("| +\(salesNumber) vendidos")
                .font(.system(size: 9, weight: .bold, design: .rounded))
                .foregroundColor(.gray)
            }
            Spacer()
            if let reputation: Double = product.seller?.sellerReputation?.transactions?.ratings?.positive {
              Text(String(reputation))
                .font(.system(size: 9, weight: .bold, design: .rounded))
                .foregroundColor(.gray)
            }
            
          }
        }
        
        HStack {
          Text(product.title)
            .font(.system(.headline, design: .rounded, weight: .light))
          Spacer()
        }
        
        if let variations = product.variationsData {
          TabView {
            ForEach(variations.map({ $0 }), id: \.key) { variation in
              ImageView(image: variation.value.thumbnail ?? "", contentMode: .fit)
            }
          }
          .tabViewStyle(.page)
          .frame(height: 400)
        } else if let thumbnail: String = product.thumbnail {
          ImageView(image: thumbnail, contentMode: .fit)
            .frame(height: 400)
        } else {
          EmptyView()
            .frame(height: 400)
        }
        
        VStack {
          HStack {
            Text(String("$ \(product.price.formattedWithInteger)"))
              .font(.system(.title, weight: .regular))
            Spacer()
          }
          if let installments: Installments = product.installments,
             let quantity: Int = installments.quantity {
            HStack {
              Text("Hasta \(quantity) cuotas")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.gray)
              Spacer()
            }
          }
        }
        
        if quantityArray.count > 1 {
          HStack {
            Text("Stock disponible")
              .font(.system(size: 14, weight: .bold, design: .default))
            Spacer()
          }
        }
        
        Menu {
          ForEach(quantityArray, id: \.self) { quantity in
            Button(action: {
              selectedQuantity = quantity
            }) {
              Text("Unidades \(quantity)")
            }
          }
        } label: {
          DetailProductButton(
            title: "Cantidad: \(selectedQuantity) (\(quantityArray.count) disponibles)",
            backgroundColor: .gray.opacity(0.1),
            foregroundColor: .gray)
          .padding(.bottom, 10)
        }
        .menuStyle(.borderlessButton)
        
        VStack(spacing: 10) {
          DetailProductButton(
            title: "Comprar ahora",
            backgroundColor: .blue,
            foregroundColor: .white,
            action: {
              selectedTab = .purchase
            })
          DetailProductButton(
            title: "Agregar al carrito",
            backgroundColor: .blue.opacity(0.2),
            foregroundColor: .blue,
            action: {
              selectedTab = .purchase
            })
          
        }
      }
      .padding()
    }
  }
}

struct DetailProductButton: View {
  var title: String
  var backgroundColor: Color
  var foregroundColor: Color
  var action: (() -> Void)? = nil
  
  var body: some View {
    Button(action: {
      action?()
    }) {
      Text(title)
        .font(.system(size: 16))
        .fontWeight(.regular)
        .foregroundColor(foregroundColor)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(7)
    }
  }
}
