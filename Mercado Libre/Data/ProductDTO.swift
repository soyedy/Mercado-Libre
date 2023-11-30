//
//  ProductDTO.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import Foundation

struct ProductDTO: Codable {
    let siteId: String
    let query: String
    let paging: Paging
    let results: [Product]
    
    enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case query, paging, results
    }
}

struct Paging: Codable {
    let total: Int
    let offset: Int
    let limit: Int
    let primaryResults: Int

    enum CodingKeys: String, CodingKey {
        case total, offset, limit
        case primaryResults = "primary_results"
    }
}

struct Product: Codable {
    let id: String
    let siteId: String
    let title: String
    let price: Double
    let currencyId: String
    let availableQuantity: Int
    let categoryId: String
    let thumbnail: String
    let acceptsMercadopago: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case siteId = "site_id"
        case title, price
        case currencyId = "currency_id"
        case availableQuantity = "available_quantity"
        case categoryId = "category_id"
        case thumbnail
        case acceptsMercadopago = "accepts_mercadopago"
    }
}

