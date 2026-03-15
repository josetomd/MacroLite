//
//  ContentView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 12-03-26.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel: FoodListViewModel
    @State private var isShowingLibrary = false

    let libraryRepo = MockFoodProductRepository()
    @State private var libraryViewModel: FoodLibraryViewModel
    init(viewModel: FoodListViewModel, libraryViewModel: FoodLibraryViewModel) {
        self._libraryViewModel = State(initialValue: libraryViewModel)
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button { isShowingLibrary = true } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }

                ToolbarItem(placement: .principal) {
                    DateSelectorView(selectedDate: $viewModel.selectedDate)
                }
            }
            .fullScreenCover(isPresented: $isShowingLibrary) {
                FoodLibraryView(viewModel: libraryViewModel, mode: .select) { newEntry in
                     viewModel.addEntry(newEntry)
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
    let productRepo = MockFoodProductRepository()
    let _ = mockRepo.foods = FoodEntry.mockList
    ContentView(viewModel: .init(foodRepository: mockRepo), libraryViewModel: .init(repository: productRepo))
}
