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
                totalCalories: allEntries.reduce(0) { $0 + $1.calories },
                totalCarbs: allEntries.reduce(0) { $0 + $1.carbohydrates },
                totalProteins: allEntries.reduce(0) { $0 + $1.proteins },
                totalFats: allEntries.reduce(0) { $0 + $1.fats }
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
