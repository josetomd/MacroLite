//
//  FoodProduct.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 13-03-26.
//

import Foundation

struct FoodProduct: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var name: String
    var calories: Int
    var proteins: Double
    var carbohydrates: Double
    var fats: Double
    var grams: Double
}
