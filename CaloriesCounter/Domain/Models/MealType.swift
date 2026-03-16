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
}
