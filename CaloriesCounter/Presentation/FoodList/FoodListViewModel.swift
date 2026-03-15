//
//  FoodListViewModel.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 12-03-26.
//

import Foundation
import Observation

@Observable
class FoodListViewModel {
    var selectedDate: Date = .now
    var errorMessage: String?
    var showErrorMessage = false

    var allEntries: [FoodEntry] = []
    private let foodRepository: FoodEntryRepositoryProtocol

    var groupedFoods: [MealType: [FoodEntry]] {
        Dictionary(grouping: allEntries) { $0.mealType }
    }

    var nutritionSummary: NutritionSummary {
        NutritionSummary(
            totalCalories: allEntries.reduce(0) { $0 + $1.totalCalories },
            totalCarbs: allEntries.reduce(0) { $0 + $1.totalCarbs },
            totalProteins: allEntries.reduce(0) { $0 + $1.totalProteins },
            totalFats: allEntries.reduce(0) { $0 + $1.totalFats }
        )
    }

    init(foodRepository: FoodEntryRepositoryProtocol) {
        self.foodRepository = foodRepository
        loadData()
    }

    func loadData() {
        do {
            self.allEntries = try foodRepository.fetch(for: selectedDate)
        } catch {
            self.errorMessage = "Couldn't load foods"
            self.showErrorMessage = true
        }
    }
}
