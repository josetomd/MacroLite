//
//  FoodProductRepositoryProtocol.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 13-03-26.
//

import Foundation

protocol FoodProductRepositoryProtocol {
    func fetchProducts() throws -> [FoodProduct]
    func searchProducts(query: String) throws -> [FoodProduct]
    func saveProduct(_ food: FoodProduct) throws -> Void
    func deleteProduct(id: UUID) throws -> Void
    func updateProduct(_ food: FoodProduct) throws -> Void
}
