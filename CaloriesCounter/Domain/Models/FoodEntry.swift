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

    var totalCalories: Int {
        calories * amount
    }

    var totalProteins: Double {
        proteins * Double(amount)
    }

    var totalCarbs: Double {
        carbohydrates * Double(amount)
    }

    var totalFats: Double {
        fats * Double(amount)
    }

    var totalGrams: Double {
        grams * Double(amount)
    }

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
    
    init(from product: FoodProduct, amount: Int, mealType: MealType) {
        self.id = UUID()
        self.name = product.name
        self.calories = product.calories
        self.proteins = product.proteins
        self.carbohydrates = product.carbohydrates
        self.fats = product.fats
        self.grams = product.grams
        self.amount = amount
        self.mealType = mealType
        self.date = Date()

    }
}

extension FoodEntry {
    static var mockList: [FoodEntry] {
        let tomorrow = Date().addingTimeInterval(86400)
        let yesterday = Date().addingTimeInterval(-86400)
        return [
            .init(name: "Banana", calories: 105, proteins: 1.3, carbohydrates: 27.0, fats: 0.4, grams: 100, amount: 1, mealType: .breakfast, date: Date()),
            .init(name: "Egg", calories: 78, proteins: 6.0, carbohydrates: 0.0, fats: 5.0, grams: 1, amount: 1, mealType: .breakfast, date: tomorrow),
            .init(name: "Avocado", calories: 234, proteins: 2.0, carbohydrates: 8.1, fats: 20.0, grams: 100, amount: 1, mealType: .lunch, date: yesterday),
            .init(name: "Chicken breast", calories: 140, proteins: 27.0, carbohydrates: 0.0, fats: 1.0, grams: 100, amount: 1, mealType: .dinner, date: Date()),
        ]
    }
}
