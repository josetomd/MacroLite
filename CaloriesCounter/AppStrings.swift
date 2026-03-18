//
//  AppStrings.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 18-03-26.
//


import Foundation

struct AppStrings {
    
    struct Onboarding {
        static let welcomeTitle = LocalizedStringResource("onboarding.welcome.title")
        static let welcomeSubtitle = LocalizedStringResource("onboarding.welcome.subtitle")

        static let goalsTitle = LocalizedStringResource("onboarding.goals.title")
        static let goalsSubtitle = LocalizedStringResource("onboarding.goals.subtitle")
        static let standardValuesButton = LocalizedStringResource("onboarding.goals.standard_values")

        static let readyTitle = LocalizedStringResource("onboarding.ready.title")
        static let readySubtitle = LocalizedStringResource("onboarding.ready.subtitle")
        
        static let nextButton = LocalizedStringResource("onboarding.button.next")
        static let startButton = LocalizedStringResource("onboarding.button.start")

        static let validationError = LocalizedStringResource("onboarding.error.validation")
    }
    
    struct Macros {
        static let calories = LocalizedStringResource("macro.label.calories")
        static let protein = LocalizedStringResource("macro.label.protein")
        static let carbs = LocalizedStringResource("macro.label.carbs")
        static let fats = LocalizedStringResource("macro.label.fats")
    }
}
