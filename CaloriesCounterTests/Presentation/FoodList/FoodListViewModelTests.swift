//
//  FoodListViewModelTests.swift
//  CaloriesCounterTests
//
//  Created by Josset Garcia on 12-03-26.
//

import Testing
import Foundation
@testable import CaloriesCounter

struct FoodListViewModelTests {

    @Test func summaryMacronutrients_areCalculatedCorrecty() {
        let mockRepo = MockFoodEntryRepository()
        let food1 = FoodEntry(name: "Manzana", calories: 100, proteins: 0, carbohydrates: 25, fats: 0, grams: 150, amount: 1, mealType: .snack, date: .now)
        let food2 = FoodEntry(name: "Pollo", calories: 300, proteins: 30, carbohydrates: 0, fats: 5, grams: 200, amount: 1, mealType: .lunch, date: .now)
        mockRepo.foods = [food1, food2]

        let sut = FoodListViewModel(foodRepository: mockRepo, hapticManager: MockHapticManager(), soundManager: MockSoundManager())

        sut.loadData()

        #expect(sut.nutritionSummary.totalCalories == 400)
        #expect(sut.nutritionSummary.totalProteins == 30.0)
        #expect(sut.nutritionSummary.totalCarbs == 25.0)
        #expect(sut.nutritionSummary.totalFats == 5.0)
    }

    @Test func groupedFoods_separatesByMealTypeCorrecty() {
        let mockRepo = MockFoodEntryRepository()
        mockRepo.foods = [
            FoodEntry(name: "Avena", calories: 200, proteins: 5, carbohydrates: 30, fats: 3, grams: 50, amount: 1, mealType: .breakfast, date: .now),
            FoodEntry(name: "Tostada", calories: 150, proteins: 3, carbohydrates: 20, fats: 2, grams: 30, amount: 1, mealType: .breakfast, date: .now)
        ]
        let sut = FoodListViewModel(foodRepository: mockRepo, hapticManager: MockHapticManager(), soundManager: MockSoundManager())

        sut.loadData()

        #expect(sut.groupedFoods[.breakfast]?.count == 2)
        #expect(sut.groupedFoods[.lunch] == nil)
    }

    @Test func selectedDate_FetchFoodsByDateCorrectly() {
        let mockRepo = MockFoodEntryRepository()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: .now)!
        mockRepo.foods = [
            FoodEntry(name: "Avena", calories: 200, proteins: 5, carbohydrates: 30, fats: 3, grams: 50, amount: 1, mealType: .breakfast, date: .now),
            FoodEntry(name: "Tostada", calories: 150, proteins: 3, carbohydrates: 20, fats: 2, grams: 30, amount: 1, mealType: .breakfast, date: tomorrow)
        ]

        let sut = FoodListViewModel(foodRepository: mockRepo, hapticManager: MockHapticManager(), soundManager: MockSoundManager())
        sut.loadData()

        #expect(sut.allEntries.count == 1)
        #expect(sut.allEntries.first?.name == "Avena")

        sut.selectedDate = tomorrow
        sut.loadData()

        #expect(sut.allEntries.count == 1)
        #expect(sut.allEntries.first?.name == "Tostada")
    }

    @Test func givenIndexToDelete_deleteEntry_callsDeleteFromRepository() {
        let mockRepo = MockFoodEntryRepository()
        let id = UUID()
        let avena = FoodEntry(id: id, name: "Avena", calories: 200, proteins: 5, carbohydrates: 30, fats: 3, grams: 50, amount: 1, mealType: .breakfast, date: .now)
        mockRepo.foods = [avena]

        let sut = FoodListViewModel(foodRepository: mockRepo, hapticManager: MockHapticManager(), soundManager: MockSoundManager())
        sut.loadData()

        sut.deleteEntry(id: id)

        #expect(mockRepo.deleteWasCalled == true)
        #expect(mockRepo.foods.isEmpty == true)
    }
}
