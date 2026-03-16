//
//  MacroBreakdownViewModelTests.swift
//  CaloriesCounterTests
//
//  Created by Josset Garcia on 16-03-26.
//

import Foundation
import Testing
@testable import CaloriesCounter

struct MacroBreakdownViewModelTests {

    @Test func filteredEntires_sortCorrectlyFromHighestToLowestForCalories() async throws {
        let entries: [FoodEntry] = [
            .init(name: "Banana", calories: 70, proteins: 0, carbohydrates: 27, fats: 0, grams: 1, amount: 1, mealType: .breakfast, date: Date()),
            .init(name: "Egg", calories: 108, proteins: 6, carbohydrates: 0, fats: 5, grams: 1, amount: 1, mealType: .breakfast, date: Date()),
        ]
        let sut = MacroBreakdownViewModel(macroType: .calories, entries: entries)

        let expectedEgg = sut.filteredEntries.first!

        #expect(expectedEgg.name == "Egg")
        #expect(expectedEgg.calories == 108)
    }

    @Test func totalValue_returnsCorrectValueForCalories() async throws {
        let entries: [FoodEntry] = [
            .init(name: "Banana", calories: 70, proteins: 0, carbohydrates: 27, fats: 0, grams: 1, amount: 2, mealType: .breakfast, date: Date()),
            .init(name: "Egg", calories: 100, proteins: 6, carbohydrates: 0, fats: 5, grams: 1, amount: 3, mealType: .breakfast, date: Date()),
        ]

        let sut = MacroBreakdownViewModel(macroType: .calories, entries: entries)

        #expect(sut.totalValue == 440)
    }
}
