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
    var userSettings = UserSettings()
    var allEntries: [FoodEntry] = []
    private let foodRepository: FoodEntryRepositoryProtocol
    private let hapticManager: HapticProvider
    private let soundManager: SoundProvider

    var groupedFoods: [MealType: [FoodEntry]] {
        Dictionary(grouping: allEntries) { $0.mealType }
    }

    var nutritionSummary: NutritionSummary {
        NutritionSummary(
            totalCalories: allEntries.reduce(0) { $0 + $1.totalCalories },
            totalCarbs: allEntries.reduce(0) { $0 + $1.totalCarbs },
            totalProteins: allEntries.reduce(0) { $0 + $1.totalProteins },
            totalFats: allEntries.reduce(0) { $0 + $1.totalFats },
            caloriesGoal: userSettings.targetCalories,
                        carbsGoal: userSettings.targetCarbs,
                        proteinGoal: userSettings.targetProtein,
                        fatGoal: userSettings.targetFats
        )
    }

    init(foodRepository: FoodEntryRepositoryProtocol,
    hapticManager: HapticProvider = HapticManager.shared,
    soundManager: SoundProvider = SoundManager.shared) {
        self.foodRepository = foodRepository
        self.hapticManager = hapticManager
        self.soundManager = soundManager
        loadData()
    }

    func loadData() {
        do {
            self.allEntries = try foodRepository.fetch(for: selectedDate)
        } catch {
            handleError(error)
        }
    }

    func addEntry(_ entry: FoodEntry) {
        var finalEntry = entry
        finalEntry.date = selectedDate

        do {
            try foodRepository.save(finalEntry)
            soundManager.play(sound: .success)
        } catch {
            handleError(error)
        }
        loadData()
    }

    func updateEntry(_ entry: FoodEntry) {
        do {
            try foodRepository.update(entry)
            soundManager.play(sound: .success)
        } catch {
            handleError(error)
        }
        loadData()
    }

    func deleteEntry(id: UUID) {
        do {
            try foodRepository.delete(id: id)
            soundManager.play(sound: .delete)
        } catch {
            handleError(error)
        }
        loadData()
    }

    private func handleError(_ error: Error) {
        self.errorMessage = error.localizedDescription
        self.showErrorMessage = true
        soundManager.play(sound: .error)
    }
}
