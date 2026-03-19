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
    var mode: LibraryMode
    var navigationTitle: LocalizedStringResource {
        mode == .manage ? AppStrings.Library.navigationManageModeTitle : AppStrings.Library.navigationSelectModeTitle
    }
    
    private(set) var filteredProducts: [FoodProduct] = []

    private let repository: FoodProductRepositoryProtocol

    init(repository: FoodProductRepositoryProtocol, mode: LibraryMode) {
        self.repository = repository
        self.mode = mode
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

    func getFoodProductRepository() -> FoodProductRepositoryProtocol {
        repository
    }

    func deleteProduct(offsets: IndexSet) {
        offsets.forEach { index in
            let product = self.filteredProducts[index]
            do {
                try repository.deleteProduct(id: product.id)
                SoundManager.shared.play(sound: .delete)
            } catch {
                handleError(error)
            }
        }
    }

    private func handleError(_ error: Error) -> Void {
        errorMessage = error.localizedDescription
        showMessage = true
        SoundManager.shared.play(sound: .error)
    }
}
