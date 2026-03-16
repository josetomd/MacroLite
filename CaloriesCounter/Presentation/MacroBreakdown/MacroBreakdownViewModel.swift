//
//  MacroBreakdownViewModel.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 16-03-26.
//

import Foundation
import Observation

@Observable
class MacroBreakdownViewModel {
    let macroType: MacroType
    private let allEntries: [FoodEntry]
    
    var filteredEntries: [FoodEntry] {
        allEntries
            .filter { $0.value(for: macroType) > 0 }
            .sorted { $0.value(for: macroType) > $1.value(for: macroType) }
    }
    
    var totalValue: Double {
        filteredEntries.reduce(0) { $0 + $1.value(for: macroType) }
    }

    init(macroType: MacroType, entries: [FoodEntry]) {
        self.macroType = macroType
        self.allEntries = entries
    }
}
