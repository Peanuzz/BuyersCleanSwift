//
//  Models.swift
//  BuyerClean
//
//  Created by Peanuz on 2/9/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation

//typealias Model = [Phone]

struct Phone: Codable {
    let rating: Double
    let id: Int
    let thumbImageURL: String
    let price: Double
    let brand, name, description: String
}

struct DisplayedPhone {
    let id: Int
    let rating: Double
    let thumbImageURL: String
    let price: Double
    let name, description: String
}
