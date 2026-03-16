////
////  FoodDetailViewModel.swift
////  CaloriesCounter
////
////  Created by Josset Garcia on 14-03-26.
////
//

import Foundation
import Observation

@Observable
class FoodDetailViewModel {
    let product: FoodProduct
    var selectedAmount: Int = 1
    var selectedMealType: MealType
    let entryId: UUID?

    var isEditing: Bool {
        entryId != nil
    }

    var totalGrams: Double {
        product.grams * Double(selectedAmount)
    }

    init(product: FoodProduct,
         amount: Int = 1,
         mealType: MealType = .breakfast,
         entryId: UUID? = nil) {
        self.product = product
        self.selectedAmount = amount
        self.selectedMealType = mealType
        self.entryId = entryId
    }

    func createEntry() -> FoodEntry {
        if let id = entryId {
            return FoodEntry(id: id, from: product, amount: selectedAmount, mealType: selectedMealType)
        } else {
            return FoodEntry(from: product, amount: selectedAmount, mealType: selectedMealType)
        }
    }
}
