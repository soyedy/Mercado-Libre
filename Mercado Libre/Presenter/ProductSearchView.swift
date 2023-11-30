//
//  ContentView.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import SwiftUI

struct ProductSearchView: View {
  @State private var searchText: String = ""
  @ObservedObject private var viewModel = ProductViewModel()
  
  var body: some View {
    NavigationView {
      ZStack {
        VStack {
          TextField("Buscar en Mercado Libre", text: $searchText)
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
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
      .background(Color.yellow)
    }
    .onChange(of: searchText) { newText in
      Task {
        do {
          try await viewModel.fetchProducts(withName: newText)
        } catch {
          print("error fetching")
        }
      }
    }
  }
}


struct ProductView: View {
  var title: String
  var price: Double
  var imageUrl: URL?
  
  var body: some View {
    VStack(alignment: .leading) {
      if let imgUrl = imageUrl {
        AsyncImage(url: imgUrl) { phase in
          switch phase {
          case .empty:
            ProgressView()
          case .success(let image):
            image.resizable()
          case .failure:
            Image(systemName: "photo")
          @unknown default:
            EmptyView()
          }
        }
      } else {
        Image(systemName: "photo")
      }
      Text(title)
      Text(String(price))
    }
  }
}

