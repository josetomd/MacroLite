//
//  FoodProductFormViewModel.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 15-03-26.
//

import SwiftUI

@Observable
class FoodProductFormViewModel {
    var errorMessage: String?
    var showError: Bool = false

    var name: String = ""
    var calories: String = ""
    var proteins: String = ""
    var carbs: String = ""
    var fats: String = ""
    var grams: String = ""

    private let repository: FoodProductRepositoryProtocol
    private var existingProduct: FoodProduct?

    var isEditing: Bool { existingProduct != nil}

    init(repository: FoodProductRepositoryProtocol, product: FoodProduct? = nil) {
        self.repository = repository
        if let p = product {
            self.existingProduct = p
            self.name = p.name
            self.calories = String(p.calories)
            self.proteins = String(p.proteins)
            self.carbs = String(p.carbohydrates)
            self.fats = String(p.fats)
            self.grams = String(Int(p.grams))
        }
    }

    func save() {
        do {
            let parsedCalories = Int(parseDouble(calories))
            let parsedProteins = parseDouble(proteins)
            let parsedCarbs = parseDouble(carbs)
            let parsedFats = parseDouble(fats)
            let parsedGrams = parseDouble(grams)

            if existingProduct != nil {
                existingProduct?.name = name
                existingProduct?.calories = parsedCalories
                existingProduct?.proteins = parsedProteins
                existingProduct?.carbohydrates = parsedCarbs
                existingProduct?.fats = parsedFats
                existingProduct?.grams = parsedGrams > 0 ? parsedGrams : 100

                try repository.updateProduct(existingProduct!)

            } else {
                let newProduct = FoodProduct(
                    id: existingProduct?.id ?? UUID(),
                    name: name,
                    calories: parsedCalories,
                    proteins: parsedProteins,
                    carbohydrates: parsedCarbs,
                    fats: parsedFats,
                    grams: parsedGrams > 0 ? parsedGrams : 100
                )
                try repository.saveProduct(newProduct)
            }
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }

    func delete() {
        if let id = existingProduct?.id {
            do {
                try repository.deleteProduct(id: id)
            } catch {
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }

    private func parseDouble(_ value: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        let cleanedValue = value.replacingOccurrences(of: ",", with: ".")

        if let number = formatter.number(from: value) {
            return number.doubleValue
        } else if let fallbackNumber = Double(cleanedValue) {
            return fallbackNumber
        }

        return 0.0
    }
}
