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
      ImageView(image: product.thumbnail,
                frameWidth: 100,
                frameHeight: 100)
      VStack(alignment: .leading) {
        Text(product.title)
        Text(product.price.formattedWithInteger)
          .fontWeight(.semibold)
      }
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
        Text(product.title)
          .font(.system(.headline, design: .default, weight: .light))
        Divider()
        ImageView(image: product.thumbnail, contentMode: .fit)
        Text(String("$ \(product.price)"))
          .font(.system(.title, design: .rounded, weight: .semibold))
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
