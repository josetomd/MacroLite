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

    struct MainTab {
        static let tabLogTitle = LocalizedStringResource("maintab.log.title")
        static let tabFoodsTitle = LocalizedStringResource("maintab.foods.title")
    }

    struct Library {
        struct EmptyState {
            static let title = LocalizedStringResource("library.emptystate.title")
            static let message = LocalizedStringResource("library.emptystate.message")
            static let button = LocalizedStringResource("library.emptystate.button")
        }

        static let navigationManageModeTitle = LocalizedStringResource("library.navigation.manage_title")
        static let navigationSelectModeTitle = LocalizedStringResource("library.navigation.select_title")
        static let navigationCloseButton = LocalizedStringResource("library.navigation.close_button")
    }

    struct FoodProductForm {
        static let namePlaceholder = LocalizedStringResource("food_product_form.name_placeholder")
        static let eachPlaceholder = LocalizedStringResource("food_product_form.each_placeholder")
        static let nutritionalFactsText = LocalizedStringResource("food_product_form.nutritional_facts_text")
        static let macroRowCaloriesLabel = LocalizedStringResource("food_product_form.macro_row.calories_label")
        static let macroRowProteinsLabel = LocalizedStringResource("food_product_form.macro_row.proteins_label")
        static let macroRowCarbsLabel = LocalizedStringResource("food_product_form.macro_row.carbs_label")
        static let macroRowFatsLabel = LocalizedStringResource("food_product_form.macro_row.fats_label")
        static let saveButton = LocalizedStringResource("food_product_form.save_button")
        static let deleteButton = LocalizedStringResource("food_product_form.delete_button")
        static let alertTitle = LocalizedStringResource("food_product_form.alert_title")
        static let alertMessage = LocalizedStringResource("food_product_form.alert_message")
        static let alertButtonDelete = LocalizedStringResource("food_product_form.alert_button_delete")
        static let alertButtonCancel = LocalizedStringResource("food_product_form.alert_button_cancel")

        struct Keyboard{
            static let done = LocalizedStringResource("food_product_form.keyboard.done")
            static let next = LocalizedStringResource("food_product_form.keyboard.next")
        }
    }
    struct Macros {
        static let calories = LocalizedStringResource("macro.label.calories")
        static let protein = LocalizedStringResource("macro.label.protein")
        static let carbs = LocalizedStringResource("macro.label.carbs")
        static let fats = LocalizedStringResource("macro.label.fats")
    }
}
