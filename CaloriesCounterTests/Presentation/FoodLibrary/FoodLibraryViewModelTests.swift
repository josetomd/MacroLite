//
//  FoodLibraryViewModelTests.swift
//  CaloriesCounterTests
//
//  Created by Josset Garcia on 13-03-26.
//

import Testing
@testable import CaloriesCounter

struct FoodLibraryViewModelTests {

    @Test func givenPolperformSearch_fetchCorrectProducts() async throws {
        let mockRepo = MockFoodProductRepository()
        let pechuga = FoodProduct(name: "Pechuga de Pollo", calories: 165, proteins: 31, carbohydrates: 0, fats: 3.6, grams: 100)

        let avena = FoodProduct(name: "Avena", calories: 389, proteins: 16.9, carbohydrates: 66, fats: 6.9, grams: 100)
        mockRepo.products = [pechuga, avena]

        let sut = FoodLibraryViewModel(repository: mockRepo)
        
        sut.searchText = "Pe"
        sut.performSearch()

        #expect(sut.filteredProducts.count == 1)
        #expect(sut.filteredProducts.first!.name == "Pechuga de Pollo")
    }

    @Test func givenIndexToDelete_deleteProduct_callsDeleteFromRepository() {
        let mockRepo = MockFoodProductRepository()
        let pechuga = FoodProduct(name: "Pechuga de Pollo", calories: 165, proteins: 31, carbohydrates: 0, fats: 3.6, grams: 100)
        mockRepo.products = [pechuga]

        let sut = FoodLibraryViewModel(repository: mockRepo)
        sut.loadInitialProducts()

        sut.deleteProduct(offsets: .init(integer: 0))

        #expect(mockRepo.deleteWasCalled == true)
        #expect(mockRepo.products.isEmpty == true)
    }
}
