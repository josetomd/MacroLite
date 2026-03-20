//
//  FoodDetailViewModelTests.swift
//  CaloriesCounterTests
//
//  Created by Josset Garcia on 15-03-26.
//

import Testing
import Foundation
@testable import CaloriesCounter

struct FoodDetailViewModelTests {

    @Test func givenID_createEntry_updateEntryCorrectly() {
        let id = UUID()
        let product = FoodProduct(name: "Avena", calories: 100, proteins: 20, carbohydrates: 30, fats: 40, grams: 50)
        let entry = FoodEntry(id: id, name: "Avena", calories: 100, proteins: 20, carbohydrates: 30, fats: 40, grams: 50, amount: 1, mealType: .breakfast, date: .now)

        let sut = FoodDetailViewModel(product: product, entryId: id, hapticManager: MockHapticManager())
        let createdEntry = sut.createEntry()

        #expect(createdEntry.id == id)
    }

    @Test func givenEmptyID_createEntry_createNewEntry() {
        let product = FoodProduct(name: "Avena", calories: 100, proteins: 20, carbohydrates: 30, fats: 40, grams: 50)

        let sut = FoodDetailViewModel(product: product)
        let createdEntry = sut.createEntry()
        
        #expect(createdEntry.calories == 100)
        #expect(createdEntry.grams == 50)
        #expect(createdEntry.name == "Avena")
    }
}
