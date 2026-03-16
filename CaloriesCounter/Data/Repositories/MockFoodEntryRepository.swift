//
//  MockFoodEntryRepository.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 12-03-26.
//

import Foundation

class MockFoodEntryRepository: FoodEntryRepositoryProtocol {
    var foods: [FoodEntry] = []
    var deleteWasCalled = false

    func save(_ food: FoodEntry) throws {
        foods.append(food)
    }

    func delete(id: UUID) throws {
        deleteWasCalled = true
        foods.removeAll { $0.id == id }
    }

    func fetchAll() throws -> [FoodEntry] {
        return foods
    }

    func fetch(for date: Date) throws -> [FoodEntry] {
        let calendar = Calendar.current
        return foods.filter { food in
            calendar.isDate(food.date, inSameDayAs: date)
        }
    }

    func update(_ food: FoodEntry) throws {
        if let index = foods.firstIndex(where: { $0.id == food.id }) {
            foods[index] = food
        }
    }
}
