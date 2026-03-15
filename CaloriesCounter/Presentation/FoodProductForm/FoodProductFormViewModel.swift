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
    var grams: String = "100"
    
    private let repository: FoodProductRepositoryProtocol
    private var existingProduct: FoodProduct?

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

    func save()  {
        let newProduct = FoodProduct(
            id: existingProduct?.id ?? UUID(),
            name: name,
            calories: Int(calories) ?? 0,
            proteins: Double(proteins) ?? 0,
            carbohydrates: Double(carbs) ?? 0,
            fats: Double(fats) ?? 0,
            grams: Double(grams) ?? 100
        )
        do {
            try repository.saveProduct(newProduct)
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
