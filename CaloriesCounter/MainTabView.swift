//
//  MainTabView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 14-03-26.
//

import SwiftUI

struct MainTabView: View {
    @State private var entryRepo: FoodEntryRepositoryProtocol
    @State private var productRepo: FoodProductRepositoryProtocol

    init(entryRepo: FoodEntryRepositoryProtocol, productRepo: FoodProductRepositoryProtocol) {
        self._entryRepo = State(initialValue: entryRepo)
        self._productRepo = State(initialValue: productRepo)
    }
    var body: some View {
        TabView {
            ContentView(viewModel: FoodListViewModel(foodRepository: entryRepo), libraryViewModel: .init(repository: productRepo))
                .tabItem {
                    Label("Diario", systemImage: "calendar")
                }

            FoodLibraryView(
                viewModel: FoodLibraryViewModel(repository: productRepo),
                mode: .manage
            )
            .tabItem {
                Label("Alimentos", systemImage: "fork.knife")
            }
        }
    }
}

#Preview {
    MainTabView(entryRepo: MockFoodEntryRepository(), productRepo: MockFoodProductRepository())
}
