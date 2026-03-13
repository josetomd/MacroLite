//
//  ContentView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 12-03-26.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel: FoodListViewModel

    init(viewModel: FoodListViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    NutritionHeader(summary: viewModel.nutritionSummary)
                    LazyVStack(spacing: 20) {
                        ForEach(MealType.allCases, id: \.self) { mealType in
                            MealSectionView(
                                title: mealType.rawValue,
                                entries: viewModel.groupedFoods[mealType] ?? []
                            )
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    DateSelectorView(selectedDate: $viewModel.selectedDate)
                }
            }
            .onChange(of: viewModel.selectedDate) { _, _ in
                viewModel.loadData()
            }
        }
    }
}

#Preview {
    let mockRepo = MockFoodRepository()
    let _ = mockRepo.foods = FoodEntry.mockList
    ContentView(viewModel: .init(foodRepository: mockRepo))
}
