//
//  FoodLibraryViewModel.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 13-03-26.
//

import Foundation
import SwiftUI

@Observable
class FoodLibraryViewModel {
    var searchText: String = ""
    var errorMessage: String?
    var showMessage: Bool = false
    private(set) var filteredProducts: [FoodProduct] = []
    
    private let repository: FoodProductRepositoryProtocol
    
    init(repository: FoodProductRepositoryProtocol) {
        self.repository = repository
        loadInitialProducts()
    }
    
    func loadInitialProducts() {
        do {
            self.filteredProducts = try repository.fetchProducts()
        } catch {
            handleError(error)
        }
    }
    
    func performSearch() {
        do {
            self.filteredProducts = try repository.searchProducts(query: searchText)
        } catch {
            handleError(error)
        }
    }

    private func handleError(_ error: Error) -> Void {
        errorMessage = error.localizedDescription
        showMessage = true
    }
}
