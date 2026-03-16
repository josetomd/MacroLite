//
//  SDFoodProductRepository.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 16-03-26.
//

import Foundation
import SwiftData

class SDFoodProductRepository: FoodProductRepositoryProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchProducts() throws -> [FoodProduct] {
        let descriptor = FetchDescriptor<FoodProduct>(sortBy: [SortDescriptor(\.name)])
        return try context.fetch(descriptor)
    }
    
    func searchProducts(query: String) throws -> [FoodProduct] {
        guard !query.isEmpty else { return try fetchProducts() }
        
        let predicate = #Predicate<FoodProduct> { product in
            product.name.localizedStandardContains(query)
        }
        let descriptor = FetchDescriptor<FoodProduct>(predicate: predicate)
        return try context.fetch(descriptor)
    }
    
    func saveProduct(_ food: FoodProduct) throws {
        context.insert(food)
        try context.save()
    }
    
    func deleteProduct(id: UUID) throws {
        let predicate = #Predicate<FoodProduct> { $0.id == id }
        try context.delete(model: FoodProduct.self, where: predicate)
        try context.save()
    }
    
    func updateProduct(_ food: FoodProduct) throws {
        try context.save()
    }
}
