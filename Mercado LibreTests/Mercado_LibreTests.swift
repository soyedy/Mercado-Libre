//
//  Mercado_LibreTests.swift
//  Mercado LibreTests
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import CoreData
import XCTest
@testable import Mercado_Libre

class FetchProductInteractorTests: XCTestCase {
  
  let repository: ProductRepository = ProductRepository(
    localManager: LocalStorageRepository(
      container: NSPersistentContainer(name: "")),
    remoteManager: NetworkProductRepository(
      service: ProductService()))
  
  func testFetchesProductsWithEmptySearch() async throws {
    // Given
    let repository = repository
    let interactor = FetchProductInteractor(repository: repository)
    
    do {
      // When
      let products = try await interactor.execute(name: "")
      
      // Then
      XCTAssertEqual(products.count, 0)
    } catch {
      XCTFail(ServiceError.noResultsFound.localizedDescription)
    }
  }
  
  func testFetchesProducts() async throws {
    // Given
    let repository = repository
    let interactor = FetchProductInteractor(repository: repository)
    
    do {
      // When
      let products = try await interactor.execute(name: "Zapatos")
      
      // Then
      XCTAssert(!products.isEmpty)
    } catch {
      XCTFail(ServiceError.noResultsFound.localizedDescription)
    }
  }
  
}
