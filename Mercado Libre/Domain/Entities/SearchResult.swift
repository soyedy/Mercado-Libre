//
//  ProductDTO.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 29/11/23.
//

import Foundation

struct SearchResult: Codable {
  let siteID, countryDefaultTimeZone, query: String?
  let paging: Paging?
  let results: [Product]?
  let installments: Installments?
  let winnerItemID: String?
  let catalogListing: Bool?
  let discounts: String?
  let promotions: [String]?
  let inventoryID: String?
  
  enum CodingKeys: String, CodingKey {
    case siteID = "site_id"
    case countryDefaultTimeZone = "country_default_time_zone"
    case query, paging, results, installments
    case winnerItemID = "winner_item_id"
    case catalogListing = "catalog_listing"
    case discounts, promotions
    case inventoryID = "inventory_id"
  }
}

// MARK: - Installments
struct Installments: Codable {
  let quantity: Int?
  let amount, rate: Double?
  let currencyID: String?
  
  enum CodingKeys: String, CodingKey {
    case quantity, amount, rate
    case currencyID = "currency_id"
  }
}

// MARK: - Paging
struct Paging: Codable {
  let total, primaryResults, offset, limit: Int?
  
  enum CodingKeys: String, CodingKey {
    case total
    case primaryResults = "primary_results"
    case offset, limit
  }
}

// MARK: - VariationsDatum
struct VariationsDatum: Codable {
  let thumbnail: String?
  let ratio, name: String?
  let picturesQty: Int?
  let inventoryID: String?
  
  enum CodingKeys: String, CodingKey {
    case thumbnail, ratio, name
    case picturesQty = "pictures_qty"
    case inventoryID = "inventory_id"
  }
}

// MARK: - Address
struct Address: Codable {
  let stateID, stateName, cityID, cityName: String?
  
  enum CodingKeys: String, CodingKey {
    case stateID = "state_id"
    case stateName = "state_name"
    case cityID = "city_id"
    case cityName = "city_name"
  }
}

// MARK: - Attribute
struct Attribute: Codable {
  let id, name, valueName: String?
  let attributeGroupID, attributeGroupName: String?
  let values: [Value]?
  let source: Int?
  let valueType: String?
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case valueName = "value_name"
    case attributeGroupID = "attribute_group_id"
    case attributeGroupName = "attribute_group_name"
    case values, source
    case valueType = "value_type"
  }
}

// MARK: - Value
struct Value: Codable {
  let id, name: String?
  let source: Int?
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case source
  }
}

// MARK: - Seller
struct Seller: Codable {
  let id: Int?
  let nickname: String?
  let carDealer, realEstateAgency, empty: Bool?
  let registrationDate: String?
  let tags: [String]?
  let carDealerLogo: String?
  let permalink: String?
  let sellerReputation: SellerReputation?
  
  enum CodingKeys: String, CodingKey {
    case id, nickname
    case carDealer = "car_dealer"
    case realEstateAgency = "real_estate_agency"
    case empty = "_"
    case registrationDate = "registration_date"
    case tags
    case carDealerLogo = "car_dealer_logo"
    case permalink
    case sellerReputation = "seller_reputation"
  }
}

// MARK: - SellerReputation
struct SellerReputation: Codable {
  let levelID, powerSellerStatus: String?
  let transactions: Transactions?
  let metrics: Metrics?
  
  enum CodingKeys: String, CodingKey {
    case levelID = "level_id"
    case powerSellerStatus = "power_seller_status"
    case transactions, metrics
  }
}

// MARK: - Metrics
struct Metrics: Codable {
  let sales: Sales?
  let claims, delayedHandlingTime, cancellations: Cancellations?
  
  enum CodingKeys: String, CodingKey {
    case sales, claims
    case delayedHandlingTime = "delayed_handling_time"
    case cancellations
  }
}

// MARK: - Cancellations
struct Cancellations: Codable {
  let period: String?
  let rate: Double?
  let value: Int?
}

// MARK: - Sales
struct Sales: Codable {
  let period: String?
  let completed: Int?
}

// MARK: - Transactions
struct Transactions: Codable {
  let canceled, completed: Int?
  let period: String?
  let ratings: Ratings?
  let total: Int?
}

// MARK: - Ratings
struct Ratings: Codable {
  let negative, neutral, positive: Double?
}

// MARK: - SellerAddress
struct SellerAddress: Codable {
  let comment, addressLine: String?
  let id, latitude, longitude: String?
  let country, state, city: City?
  
  enum CodingKeys: String, CodingKey {
    case comment
    case addressLine = "address_line"
    case id, latitude, longitude, country, state, city
  }
}

// MARK: - City
struct City: Codable {
  let id, name: String?
}

// MARK: - Shipping
struct Shipping: Codable {
  let storePickUp, freeShipping: Bool?
  let logisticType, mode: String?
  let tags: [String]?
  let benefits, promise: String?
  
  enum CodingKeys: String, CodingKey {
    case storePickUp = "store_pick_up"
    case freeShipping = "free_shipping"
    case logisticType = "logistic_type"
    case mode, tags, benefits, promise
  }
}
