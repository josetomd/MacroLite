//
//  MainTabView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 14-03-26.
//

import SwiftUI

struct MainTabView: View {
    @State private var foodRepo = MockFoodRepository()
    @State private var productRepo = MockFoodProductRepository()
    
    var body: some View {
        TabView {
            ContentView(viewModel: FoodListViewModel(foodRepository: foodRepo))
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
    MainTabView()
}
