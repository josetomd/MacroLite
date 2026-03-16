//
//  FoodProductFormViewModelTests.swift
//  CaloriesCounterTests
//
//  Created by Josset Garcia on 15-03-26.
//

import Testing
import Foundation
@testable import CaloriesCounter

struct FoodProductFormViewModelTests {

    @Test func save_newProduct_addsToRepository() throws {
        let repositoryMock = MockFoodProductRepository()
        repositoryMock.products = []
        let sut = FoodProductFormViewModel(repository: repositoryMock)

        sut.name = "Avena"
        sut.calories = "100"
        sut.proteins = "10.5"
        sut.carbs = "14"
        sut.fats = "0.2"
        sut.grams = "100"

        sut.save()

        let savedProduct = try repositoryMock.fetchProducts().first
        #expect(repositoryMock.products.count == 1)
        #expect(savedProduct?.name == "Avena")
        #expect(savedProduct?.calories == 100)
        #expect(savedProduct?.proteins == 10.5)
        #expect(savedProduct?.carbohydrates == 14)
        #expect(savedProduct?.fats == 0.2)
        #expect(savedProduct?.grams == 100)
    }

    @Test func givenExistingFood_propertiesAreSetCorrectly() {
        let repositoryMock = MockFoodProductRepository()
        let product = FoodProduct(name: "Manzana", calories: 52, proteins: 0.3, carbohydrates: 14, fats: 0.2, grams: 100)

        let sut = FoodProductFormViewModel(repository: repositoryMock, product: product)

        #expect(sut.name == "Manzana")
        #expect(sut.calories == "52")
        #expect(sut.proteins == "0.3")
        #expect(sut.carbs == "14.0")
        #expect(sut.fats == "0.2")
        #expect(sut.grams == "100")
    }

    @Test func givenExistingFood_save_updatesProductInRepository() throws {
        let repositoryMock = MockFoodProductRepository()
        let product = FoodProduct(name: "Manzana", calories: 52, proteins: 0.3, carbohydrates: 14, fats: 0.2, grams: 100)
        
        repositoryMock.products = [product]
        
        let sut = FoodProductFormViewModel(repository: repositoryMock, product: product)

        sut.name = "Manzana Roja"
        sut.calories = "32"
        sut.save()

        let foodUpdated = repositoryMock.products.first!
        #expect(repositoryMock.updateWasCalled == true)
        #expect(foodUpdated.name == "Manzana Roja")
        #expect(foodUpdated.calories == 32)
    }

    @Test func givenExistingProduct_delete_callsDeleteFromRepository() {
        let repositoryMock = MockFoodProductRepository()
        let product = FoodProduct(name: "Manzana", calories: 52, proteins: 0.3, carbohydrates: 14, fats: 0.2, grams: 100)

        repositoryMock.products = [product]

        let sut = FoodProductFormViewModel(repository: repositoryMock, product: product)

        sut.delete()

        #expect(repositoryMock.deleteWasCalled == true)
        #expect(repositoryMock.products.isEmpty == true)
    }

    @Test func givenEmptyExistingProduct_delete_doNotCallsDeleteFromRepository() {
        let repositoryMock = MockFoodProductRepository()

        let sut = FoodProductFormViewModel(repository: repositoryMock)

        sut.delete()

        #expect(repositoryMock.deleteWasCalled == false)
    }
}
