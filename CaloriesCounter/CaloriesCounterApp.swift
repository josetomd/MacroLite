//
//  CaloriesCounterApp.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 12-03-26.
//

import SwiftUI
import SwiftData

@main
struct CaloriesCounterApp: App {
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: FoodProduct.self, FoodEntry.self)
        } catch {
            fatalError("No se pudo inicializar Swift Data")
        }
    }
    var body: some Scene {
        WindowGroup {
            let foodProductRepo = SDFoodProductRepository(context: container.mainContext)
            let foodEntryRepo = SDFoodEntryRepository(context: container.mainContext)
            MainTabView(entryRepo: foodEntryRepo, productRepo: foodProductRepo)
        }
    }
}
