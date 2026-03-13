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
        VStack {
            NutritionHeader(totalCalories: viewModel.totalCalories, totalCarbs: viewModel.totalCarbs, totalProteins: viewModel.totalProteins, totalFats: viewModel.totalFats)
        }
    }
}

#Preview {
    let mockRepo = MockFoodRepository()
    ContentView(viewModel: .init(foodRepository: mockRepo))
}
