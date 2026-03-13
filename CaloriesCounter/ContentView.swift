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
            VStack {
                NutritionHeader(summary: viewModel.nutritionSummary)
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
