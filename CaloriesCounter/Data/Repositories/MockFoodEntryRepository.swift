//
//  MockFoodEntryRepository.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 13-03-26.
//

import Foundation

class MockFoodProductRepository: FoodProductRepositoryProtocol {
    var products: [FoodProduct] = [
        FoodProduct(name: "Huevo", calories: 155, proteins: 13, carbohydrates: 1.1, fats: 11, grams: 100),
        FoodProduct(name: "Arroz Blanco", calories: 130, proteins: 2.7, carbohydrates: 28, fats: 0.3, grams: 100),
        FoodProduct(name: "Pechuga de Pollo", calories: 165, proteins: 31, carbohydrates: 0, fats: 3.6, grams: 100),
        FoodProduct(name: "Avena", calories: 389, proteins: 16.9, carbohydrates: 66, fats: 6.9, grams: 100)
    ]

    func fetchProducts() throws -> [FoodProduct] {
        return products
    }

    func searchProducts(query: String) throws -> [FoodProduct] {
        guard !query.isEmpty else { return products }
        return products.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    func saveProduct(_ product: FoodProduct) throws {
        products.append(product)
    }
    func deleteProduct(id: UUID) throws {
        products.removeAll { $0.id == id }
    }
}
