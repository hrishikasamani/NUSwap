//
//  ItemStruct.swift
//  NUSwap
//
//  Created by Karyn T on 11/23/24.
//

import Foundation

struct ItemStruct: Codable {
    var itemId: String
    var name: String
    var sellerUserId: String
    var buyerUserId: String? // default as optional bc item not yet purchased
    var category: String
    var location: String
    var description: String
    var basePrice: Double
    var sealTheDealPrice: Double
    var topBidPrice: Double?
    var imageURL: String?
    var status: String // available vs sealed
    
    init(
        itemId: String = "missing",
        name: String = "error",
        sellerUserId: String = "error",
        buyerUserId: String? = nil,
        category: String = "error",
        location: String = "error",
        description: String = "error",
        basePrice: Double = 0.00,
        sealTheDealPrice: Double = 0.00,
        topBidPrice: Double? = nil,
        imageURL: String? = "missing",
        status: String = "available"

    ) {
        self.itemId = itemId
        self.name = name
        self.sellerUserId = sellerUserId
        self.buyerUserId = buyerUserId
        self.category = category
        self.location = location
        self.description = description
        self.basePrice = basePrice
        self.sealTheDealPrice = sealTheDealPrice
        self.topBidPrice = topBidPrice
        self.imageURL = imageURL
        self.status = status
    }
}

