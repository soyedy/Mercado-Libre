//
//  ContentView.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import SwiftUI

struct ProductSearchView: View {
  @State private var searchText: String = ""
  @ObservedObject private var viewModel: ProductViewModel
  
  init(viewModel: ProductViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        VStack {
          HStack(alignment: .center) {
            SearchProductTextfieldView(placeholder: viewModel.localizable.searchTextfieldTitle, text: $searchText)
            Image(systemName: "cart")
            Spacer()
          }
          ProductListUserAddress(userInfo: Cache.shared)
          ProductListView(viewModel: viewModel, searchText: $searchText)
        }
        if viewModel.productService.isLoading {
          ProgressView()
        }
      }
      .background(Color.yellow)
    }
    .onChange(of: searchText) { newText in
      Task {
        do {
          try await viewModel.fetchProducts(withName: newText)
        } catch {
          print(ServiceError.serviceFailedFetching)
        }
      }
    }
  }
}
