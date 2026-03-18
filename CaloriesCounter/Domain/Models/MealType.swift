//
//  MealType.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 12-03-26.
//

import Foundation

enum MealType: String, CaseIterable, Identifiable, Codable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"

    var id: String {
        self.rawValue
    }

    var label: LocalizedStringResource {
        switch self {
        case .breakfast:
            return AppStrings.MealType.breakfast
        case .lunch:
            return AppStrings.MealType.lunch
        case .dinner:
            return AppStrings.MealType.dinner
        case .snack:
            return AppStrings.MealType.snack
        }
    }
}
