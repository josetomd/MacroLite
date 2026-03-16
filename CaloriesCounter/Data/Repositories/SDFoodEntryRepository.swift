//
//  SDFoodEntryRepository.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 16-03-26.
//

import Foundation
import SwiftData

class SDFoodEntryRepository: FoodEntryRepositoryProtocol {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func save(_ food: FoodEntry) throws {
        context.insert(food)
        try context.save()
    }

    func delete(id: UUID) throws {
        let predicate = #Predicate<FoodEntry> { entry in
            entry.id == id
        }
        try context.delete(model: FoodEntry.self, where: predicate)
        try context.save()
    }

    func fetchAll() throws -> [FoodEntry] {
        let descriptor = FetchDescriptor<FoodEntry>(sortBy: [SortDescriptor(\.name)])
        return try context.fetch(descriptor)
    }

    func fetch(for date: Date) throws -> [FoodEntry] {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!

        let predicate = #Predicate<FoodEntry> { entry in
            entry.date >= startDate && entry.date < endDate
        }
        let descriptor = FetchDescriptor<FoodEntry>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )

        return try context.fetch(descriptor)
    }

    func update(_ food: FoodEntry) throws {
        try context.save()
    }
}
