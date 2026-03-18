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
            LogView(viewModel: FoodListViewModel(foodRepository: entryRepo), libraryViewModel: .init(repository: productRepo, mode: .select))
                .tabItem {
                    Label(String(localized: AppStrings.MainTab.tabLogTitle), systemImage: "calendar")
                }

            FoodLibraryView(
                viewModel: FoodLibraryViewModel(repository: productRepo, mode: .manage)
            )
            .tabItem {
                Label(String(localized: AppStrings.MainTab.tabFoodsTitle), systemImage: "fork.knife")
            }
        }
    }
}

#Preview("English") {
    MainTabView(entryRepo: MockFoodEntryRepository(), productRepo: MockFoodProductRepository())
}

#Preview("Spanish") {
    MainTabView(entryRepo: MockFoodEntryRepository(), productRepo: MockFoodProductRepository())
}
