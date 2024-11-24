//
//  ItemStruct.swift
//  NUSwap
//
//  Created by Karyn T on 11/23/24.
//

import Foundation

struct ItemStruct: Codable {
    var name: String
    var sellerUserId: String
    var buyerUserId: String? // default as optional bc item not yet purchased
    var category: String
    var location: String
    var description: String
    var basePrice: Double
    var sealTheDealPrice: Double
    var topBid: Double?     // default as optional bc item no new bid yet
    
    init(
        name: String = "error",
        sellerUserId: String = "error",
        buyerUserId: String? = nil,
        category: String = "error",
        location: String = "error",
        description: String = "error",
        basePrice: Double = 0.0,
        sealTheDealPrice: Double = 0.0,
        topBid: Double? = nil

    ) {
        self.name = name
        self.sellerUserId = sellerUserId
        self.buyerUserId = buyerUserId
        self.category = category
        self.location = location
        self.description = description
        self.basePrice = basePrice
        self.sealTheDealPrice = sealTheDealPrice
        self.topBid = topBid
    }
}

