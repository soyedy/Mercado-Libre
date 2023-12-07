//
//  ProductSearchView.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 4/12/23.
//

import Foundation
import SwiftUI

struct ProductView: View {
  var product: Product
  
  var body: some View {
    
    HStack(alignment: .center) {
      if let thumbnail: String = product.thumbnail {
        ImageView(image: thumbnail,
                  frameWidth: 100,
                  frameHeight: 100
        )
      }
      
      VStack(alignment: .leading, spacing: 5) {
        
        Text(product.title)
          .font(.system(size: 14, weight: .regular))
        
        if let shipping: Shipping = product.shipping,
           let freeShipping: Bool = shipping.freeShipping,
           freeShipping {
          Text("Envío gratis")
            .font(.system(size: 12, weight: .bold))
            .foregroundColor(Color.green)
        }
        
        Text("$ \(product.price.formattedWithInteger)")
          .fontWeight(.semibold)
        
        if let seller: Seller = product.seller,
           let nickname: String = seller.nickname {
          Text("por \(nickname)")
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(Color(.systemGray2))
        }
      }
      .padding()
    }
  }
}

struct SearchProductTextfieldView: View {
  var placeholder: String
  @Binding var text: String
  
  var body: some View {
    TextField(placeholder, text: $text)
      .padding(7)
      .background(Color(.systemGray6))
      .cornerRadius(8)
      .padding(.horizontal, 10)
  }
}

struct ProductListView: View {
  var viewModel: ProductViewModel
  @Binding var searchText: String
  
  var body: some View {
    List {
      ForEach(viewModel.productList.filter({ searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) }), id: \.id) { product in
        NavigationLink(destination: ProductDetailView(product: product)) {
          ProductView(product: product)
        }
      }
    }
  }
}

struct ImageView: View {
  var image: String
  var frameWidth: CGFloat?
  var frameHeight: CGFloat?
  var contentMode: ContentMode?
  
  var body: some View {
    if let imageUrl: URL = URL(string: image) {
      AsyncImage(url: imageUrl) { phase in
        switch phase {
        case .empty:
          ProgressView()
        case .success(let image):
          image
            .resizable()
            .aspectRatio(contentMode: contentMode ?? .fill)
            .frame(width: frameWidth, height: frameHeight)
            .clipped()
        case .failure:
          Image(systemName: "photo")
            .aspectRatio(contentMode: contentMode ?? .fill)
            .frame(width: frameWidth, height: frameHeight)
            .clipped()
        @unknown default:
          EmptyView()
        }
      }
    } else {
      Image(systemName: "photo")
    }
  }
}

struct ProductDetailView: View {
  var product: Product
  var body: some View {
    ZStack {
      VStack {
        HStack {
          if let condition: String = product.condition {
            Text(condition)
              .font(.system(size: 14, weight: .bold, design: .rounded))
          }
          Spacer()
        }
        HStack {
          Text(product.title)
            .font(.system(.headline, design: .rounded, weight: .light))
          Spacer()
        }
        Divider()
        
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
        
        Text(String("$ \(product.price.formattedWithInteger)"))
          .font(.system(.title, design: .rounded, weight: .semibold))
        if let installments: Installments = product.installments,
           let quantity: Int = installments.quantity {
          Text("Hasta \(quantity) cuotas")
        }
        Spacer()
      }
    }
    .padding()
  }
}

struct ProductListUserAddress: View {
  @State var userInfo: Cache
  
  var body: some View {
    HStack {
      Image(systemName: "map.circle.fill")
      Text("\(userInfo.userAddress) - \(userInfo.userCountry.uppercased()) >")
        .font(.system(size: 12, weight: .light))
        .foregroundColor(Color(.black))
        .multilineTextAlignment(.leading)
        .lineLimit(2)
      Spacer()
    }
    .padding(.horizontal)
    .padding(.vertical, 5)
  }
}
