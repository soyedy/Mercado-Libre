//
//  ContentView.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import SwiftUI

struct ProductSearchView: View {
  @State private var searchText: String = ""
  @Binding var selectedTab: TabBarItem
  @ObservedObject private var viewModel: ProductViewModel
  
  init(viewModel: ProductViewModel,
       selectedTabBar: Binding<TabBarItem>) {
    self.viewModel = viewModel
    self._selectedTab = selectedTabBar
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        VStack {
          HStack(alignment: .center) {
            SearchProductTextfieldView(placeholder: viewModel.localizable.searchTextfieldTitle, text: $searchText)
              .autocorrectionDisabled()
            
            Image(systemName: "cart")
              .onTapGesture {
                selectedTab = .purchase
              }
            Spacer()
          }
          ProductListUserAddress(userInfo: Cache.shared)
            .onTapGesture {
              selectedTab = .settings
            }
          ProductListView(viewModel: viewModel,
                          selectedTab: $selectedTab,
                          searchText: $searchText)
        }
        if viewModel.repository.remoteManager.productService.isLoading {
          ProgressView()
        }
      }
      .background(Color("MainColor"))
    }
    .onChange(of: searchText) { newText in
      Task {
        do {
          try await viewModel.fetchProducts(withName: newText)
        } catch {
          print(error.localizedDescription)
        }
      }
    }
    .onAppear {
      Task {
        do {
          try await viewModel.welcomeProducts()
        } catch let error {
          print(error.localizedDescription)
        }
        
      }
    }
  }
}
