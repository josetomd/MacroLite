//
//  FoodEntryRepositoryProtocol.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 12-03-26.
//

import Foundation

protocol FoodEntryRepositoryProtocol {
    func save(_ food: FoodEntry) throws
    func delete(id: UUID) throws
    func fetchAll() throws -> [FoodEntry]
    func fetch(for date: Date) throws -> [FoodEntry]
    func update(_ food: FoodEntry) throws
}
