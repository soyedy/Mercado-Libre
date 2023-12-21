//
//  Mercado_LibreUITests.swift
//  Mercado LibreUITests
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import XCTest

class HomeViewUITests: XCTestCase {
  
  override func setUpWithError() throws {
    continueAfterFailure = false
  }
  
  func testUIElementsExists() throws {
    let app = XCUIApplication()
    app.launch()
    
    let searchBar = app.textFields["ProductSearchField"]
    XCTAssertTrue(searchBar.exists)
    
    let userAddress = app.staticTexts["UserAddress"]
    XCTAssertTrue(userAddress.exists)
    
    let productList = app.staticTexts["ProductList"]
    XCTAssertTrue(productList.exists)
  }

}
