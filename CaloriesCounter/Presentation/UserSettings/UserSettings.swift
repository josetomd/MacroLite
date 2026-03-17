//
//  UserSettings.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 16-03-26.
//


import Foundation
import Observation

@Observable
class UserSettings {
    var targetCalories: Double {
        didSet { UserDefaults.standard.set(targetCalories, forKey: "targetCalories") }
    }
    var targetProtein: Double {
        didSet { UserDefaults.standard.set(targetProtein, forKey: "targetProtein") }
    }
    var targetCarbs: Double {
        didSet { UserDefaults.standard.set(targetCarbs, forKey: "targetCarbs") }
    }
    var targetFats: Double {
        didSet { UserDefaults.standard.set(targetFats, forKey: "targetFats") }
    }

    var isFormValid: Bool {
        targetCalories >= 500 && targetCalories <= 10000 &&
        targetProtein >= 10 &&
        targetCarbs >= 10 &&
        targetFats >= 5
    }

    init() {
        self.targetCalories = UserDefaults.standard.double(forKey: "targetCalories") == 0 ? 2000 : UserDefaults.standard.double(forKey: "targetCalories")
        self.targetProtein = UserDefaults.standard.double(forKey: "targetProtein") == 0 ? 150 : UserDefaults.standard.double(forKey: "targetProtein")
        self.targetCarbs = UserDefaults.standard.double(forKey: "targetCarbs") == 0 ? 250 : UserDefaults.standard.double(forKey: "targetCarbs")
        self.targetFats = UserDefaults.standard.double(forKey: "targetFats") == 0 ? 70 : UserDefaults.standard.double(forKey: "targetFats")
    }
}
