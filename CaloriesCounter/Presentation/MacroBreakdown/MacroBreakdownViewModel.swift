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
    var appearanceProgress: Double = 0.0
    var maxTotalValue: Double {
        totalValue
    }
    var dailyTarget: Double {
        switch macroType {
        case .calories: return 2000
        case .protein: return 150
        case .carbs: return 250
        case .fats: return 70
        }
    }

    var completionPercentage: Double {
        guard dailyTarget > 0 else { return 0 }
        let percent = totalValue / dailyTarget
        return min(percent, 1.0)
    }
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
