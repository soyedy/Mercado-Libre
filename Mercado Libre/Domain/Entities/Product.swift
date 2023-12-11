//
//  Product.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 10/12/23.
//

import Foundation

// MARK: - Result
struct Product: Codable {
  let id, title: String
  let condition: String?
  let thumbnailID: String?
  let catalogProductID, listingTypeID: String?
  let permalink: String?
  let buyingMode, siteID, categoryID, domainID: String?
  let thumbnail: String?
  let currencyID: String?
  let orderBackend: Int?
  let price: Double
  let originalPrice: Int?
  let salePrice: String?
  let soldQuantity, availableQuantity, officialStoreID: Int?
  let officialStoreName: String?
  let useThumbnailID, acceptsMercadopago: Bool?
  let tags: [String]?
  let shipping: Shipping?
  let stopTime: String?
  let seller: Seller?
  let sellerAddress: SellerAddress?
  let address: Address?
  let attributes: [Attribute]?
  let installments: Installments?
  let winnerItemID: String?
  let catalogListing: Bool?
  let discounts: String?
  let promotions: [String]?
  let inventoryID: String?
  let variationsData: [String: VariationsDatum]?
  
  enum CodingKeys: String, CodingKey {
    case id, title, condition
    case thumbnailID = "thumbnail_id"
    case catalogProductID = "catalog_product_id"
    case listingTypeID = "listing_type_id"
    case permalink
    case buyingMode = "buying_mode"
    case siteID = "site_id"
    case categoryID = "category_id"
    case domainID = "domain_id"
    case thumbnail
    case currencyID = "currency_id"
    case orderBackend = "order_backend"
    case price
    case originalPrice = "original_price"
    case salePrice = "sale_price"
    case soldQuantity = "sold_quantity"
    case availableQuantity = "available_quantity"
    case officialStoreID = "official_store_id"
    case officialStoreName = "official_store_name"
    case useThumbnailID = "use_thumbnail_id"
    case acceptsMercadopago = "accepts_mercadopago"
    case tags, shipping
    case stopTime = "stop_time"
    case seller
    case sellerAddress = "seller_address"
    case address, attributes, installments
    case winnerItemID = "winner_item_id"
    case catalogListing = "catalog_listing"
    case discounts, promotions
    case inventoryID = "inventory_id"
    case variationsData = "variations_data"
  }
}
