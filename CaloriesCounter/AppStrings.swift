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

    struct FoodDetails {
        static let gramsPerServing = LocalizedStringResource("food_details.grams_per_serving")
        static let servings = LocalizedStringResource("food_details.servings")
        static let totalGrams = LocalizedStringResource("food_details.total_grams")
        static let timeOfDay = LocalizedStringResource("food_details.time_of_day")
        static let totalToBeRegistered = LocalizedStringResource("food_details.total_to_be_registered")
        static let update = LocalizedStringResource("food_details.update")
        static let confirm = LocalizedStringResource("food_details.confirm")
        static let delete = LocalizedStringResource("food_details.delete")
        static let navigationBack = LocalizedStringResource("food_details.navigation.back")
        static let keyboardReady = LocalizedStringResource("food_details.keyboard.ready")
        static let alertTitle = LocalizedStringResource("food_details.alert.title")
        static let alertMessage = LocalizedStringResource("food_details.alert.message")
    }

    struct Macros {
        static let calories = LocalizedStringResource("macro.label.calories")
        static let protein = LocalizedStringResource("macro.label.protein")
        static let carbs = LocalizedStringResource("macro.label.carbs")
        static let fats = LocalizedStringResource("macro.label.fats")
    }

    struct FoodProductRow {
        static let per = LocalizedStringResource("food_product_row.per")
    }

    struct NutritionHeader {
        static let totalCalories = LocalizedStringResource("nutrition_header.total_calories")
    }

    struct MealSection {
        static let emptyTitle = LocalizedStringResource("meal_section.empty_title")
        static let menuEditTitle = LocalizedStringResource("meal_section.menu_edit_title")
        static let menuDeleteTitle = LocalizedStringResource("meal_section.menu_delete_title")
    }

    struct MacroBreakdown {
        static let mainSources = LocalizedStringResource("macro_breakdown.main_sources")
        static let records = LocalizedStringResource("macro_breakdown.records")
    }

    struct MealType {
        static let breakfast = LocalizedStringResource("meal_type.breakfast")
        static let lunch = LocalizedStringResource("meal_type.lunch")
        static let dinner = LocalizedStringResource("meal_type.dinner")
        static let snack = LocalizedStringResource("meal_type.snack")
    }
    struct Alert {
        static let cancelButton = LocalizedStringResource("alert.cancel_button")
        static let deleteButton = LocalizedStringResource("alert.delete_button")
    }
}
