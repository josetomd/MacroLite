//
//  FoodProduct.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 13-03-26.
//

import Foundation
import SwiftData

@Model
class FoodProduct {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var calories: Int
    var proteins: Double
    var carbohydrates: Double
    var fats: Double
    var grams: Double

    init(id: UUID = UUID(), name: String, calories: Int, proteins: Double, carbohydrates: Double, fats: Double, grams: Double) {
        self.id = id
        self.name = name
        self.calories = calories
        self.proteins = proteins
        self.carbohydrates = carbohydrates
        self.fats = fats
        self.grams = grams
    }
}
