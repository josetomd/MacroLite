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
    private let foodRepository: FoodRepositoryProtocol

    var groupedFoods: [MealType: [FoodEntry]] {
        Dictionary(grouping: allEntries) { $0.mealType }
    }

    var totalCalories: Int {
        allEntries.reduce(0) { $0 + $1.calories }
    }

    var totalFats: Double {
        allEntries.reduce(0) { $0 + $1.fats }
    }

    var totalCarbs: Double {
        allEntries.reduce(0) { $0 + $1.carbohydrates }
    }

    var totalProteins: Double {
        allEntries.reduce(0) { $0 + $1.proteins }
    }

    init(foodRepository: FoodRepositoryProtocol) {
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
