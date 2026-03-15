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

    init(product: FoodProduct, mealType: MealType = .breakfast) {
        self.product = product
        self.selectedMealType = mealType
    }

    func createEntry() -> FoodEntry {
        return FoodEntry(from: product, amount: selectedAmount, mealType: selectedMealType)
    }
}
