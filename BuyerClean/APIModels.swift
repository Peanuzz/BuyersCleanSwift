//
//  Models.swift
//  BuyerClean
//
//  Created by Peanuz on 2/9/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation

typealias Model = [Phone]

struct Phone: Codable, Equatable{
    let rating: Double
    let id: Int
    let thumbImageURL: String
    let price: Double
    let brand, name, description: String
}

typealias ModelImage = [ImagePhone]

struct ImagePhone: Codable, Equatable {
    let url: String
    let id, mobileID: Int
    
    enum CodingKeys: String, CodingKey {
        case url, id
        case mobileID = "mobile_id"
    }
}

struct DisplayedPhone: Equatable {
    let id: Int
    let rating: Double
    let thumbImageURL: String
    let price: Double
    let name, description: String
}
