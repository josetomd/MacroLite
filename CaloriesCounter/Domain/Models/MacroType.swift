//
//  MacroType.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 16-03-26.
//

import SwiftUI

enum MacroType: String, CaseIterable {
    case calories = "Calorías"
    case protein = "Proteínas"
    case carbs = "Carbohidratos"
    case fats = "Grasas"
    
    var color: Color {
        switch self {
        case .calories: return .primary
        case .protein: return .purple
        case .carbs: return .blue
        case .fats: return .orange
        }
    }
    
    var unit: String { self == .calories ? "kcal" : "g" }
}
