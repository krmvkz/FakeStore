//
//  Product.swift
//  FakeStore
//
//  Created by Arman Karimov on 17.05.2022.
//

import UIKit

// MARK: - Product
class Product: Decodable {
    let id: Int
    let title: String
    let price: Double
    let productDescription: String
    let category: String
    let image: String
    let rating: Rating

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case productDescription = "description"
        case category, image, rating
    }
}

// MARK: - Rating
class Rating: Decodable {
    let rate: Double
    let count: Int
}


