//
//  ProductSearchView.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 4/12/23.
//

import Foundation
import SwiftUI

struct ProductView: View {
  var title: String
  var price: Double
  var imageUrl: URL?
  
  var body: some View {
    HStack(alignment: .center) {
      if let imgUrl = imageUrl {
        AsyncImage(url: imgUrl) { phase in
          switch phase {
          case .empty:
            ProgressView()
          case .success(let image):
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 100, height: 100)
              .clipped()
          case .failure:
            Image(systemName: "photo")
              .frame(width: 100, height: 100)
              .clipped()
          @unknown default:
            EmptyView()
          }
        }
      } else {
        Image(systemName: "photo")
      }
      VStack(alignment: .leading) {
        Text(title)
        Text(String(price))
          .fontWeight(.bold)
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
        ProductView(title: product.title,
                    price: product.price,
                    imageUrl: URL(string: product.thumbnail)
        )
      }
    }
  }
}

