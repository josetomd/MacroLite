//
//  FoodEntry.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 12-03-26.
//

import Foundation

struct FoodEntry: Identifiable {
    var id: UUID = UUID()
    var name: String
    var calories: Int
    var proteins: Double
    var carbohydrates: Double
    var fats: Double
    var grams: Double
    var amount: Int
    var mealType: MealType
    var date: Date

    init(id: UUID = UUID(), name: String, calories: Int, proteins: Double, carbohydrates: Double, fats: Double, grams: Double, amount: Int, mealType: MealType, date: Date) {
        self.id = id
        self.name = name
        self.calories = calories
        self.proteins = proteins
        self.carbohydrates = carbohydrates
        self.fats = fats
        self.grams = grams
        self.amount = amount
        self.mealType = mealType
        self.date = date
    }
}
