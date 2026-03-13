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

    @Test func totalCalories_isCalculatedCorrecty() {
        let mockRepo = MockFoodRepository()
        let food1 = FoodEntry(name: "Manzana", calories: 100, proteins: 0, carbohydrates: 25, fats: 0, grams: 150, amount: 1, mealType: .snack, date: .now)
        let food2 = FoodEntry(name: "Pollo", calories: 300, proteins: 30, carbohydrates: 0, fats: 5, grams: 200, amount: 1, mealType: .lunch, date: .now)
        mockRepo.foods = [food1, food2]

        let sut = FoodListViewModel(foodRepository: mockRepo) 

        sut.loadData()

        #expect(sut.totalCalories == 400)
    }

    @Test func groupedFoods_separatesByMealTypeCorrecty() {
        let mockRepo = MockFoodRepository()
        mockRepo.foods = [
            FoodEntry(name: "Avena", calories: 200, proteins: 5, carbohydrates: 30, fats: 3, grams: 50, amount: 1, mealType: .breakfast, date: .now),
            FoodEntry(name: "Tostada", calories: 150, proteins: 3, carbohydrates: 20, fats: 2, grams: 30, amount: 1, mealType: .breakfast, date: .now)
        ]
        let sut = FoodListViewModel(foodRepository: mockRepo)

        sut.loadData()

        #expect(sut.groupedFoods[.breakfast]?.count == 2)
        #expect(sut.groupedFoods[.lunch] == nil)
    }

    @Test func selectedDate_FetchFoodsByDateCorrectly() {
        let mockRepo = MockFoodRepository()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: .now)!
        mockRepo.foods = [
            FoodEntry(name: "Avena", calories: 200, proteins: 5, carbohydrates: 30, fats: 3, grams: 50, amount: 1, mealType: .breakfast, date: .now),
            FoodEntry(name: "Tostada", calories: 150, proteins: 3, carbohydrates: 20, fats: 2, grams: 30, amount: 1, mealType: .breakfast, date: tomorrow)
            ]

        let sut = FoodListViewModel(foodRepository: mockRepo)
        sut.loadData()

        #expect(sut.allEntries.count == 1)
        #expect(sut.allEntries.first?.name == "Avena")
        
        sut.selectedDate = tomorrow
        sut.loadData()

        #expect(sut.allEntries.count == 1)
        #expect(sut.allEntries.first?.name == "Tostada")
    }
}
