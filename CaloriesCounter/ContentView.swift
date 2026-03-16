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
    @State private var entryToEdit: FoodEntry?
    @State private var selectedMacro: MacroType?

    @State private var libraryViewModel: FoodLibraryViewModel
    init(viewModel: FoodListViewModel, libraryViewModel: FoodLibraryViewModel) {
        self._libraryViewModel = State(initialValue: libraryViewModel)
        self._viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        NutritionHeader(summary: viewModel.nutritionSummary, selectedMacro: $selectedMacro)
                        LazyVStack(spacing: 20) {
                            ForEach(MealType.allCases, id: \.self) { mealType in
                                MealSectionView(
                                    title: mealType.rawValue,
                                    entries: viewModel.groupedFoods[mealType] ?? [],
                                    selectedEntry: $entryToEdit
                                ) { id in
                                    viewModel.deleteEntry(id: id)
                                }
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
                .sheet(item: $entryToEdit) { entry in
                    let product = FoodProduct(
                        id: UUID(),
                        name: entry.name,
                        calories: entry.calories,
                        proteins: entry.proteins,
                        carbohydrates: entry.carbohydrates,
                        fats: entry.fats,
                        grams: entry.grams
                    )

                    let detailVM = FoodDetailViewModel(
                        product: product,
                        amount: entry.amount,
                        mealType: entry.mealType,
                        entryId: entry.id
                    )

                    FoodDetailView(viewModel: detailVM) { updatedEntry in
                        viewModel.updateEntry(updatedEntry)
                        entryToEdit = nil
                    } onDelete: { id in
                        viewModel.deleteEntry(id: id)
                        entryToEdit = nil
                    }
                }
            }

            if let type = selectedMacro {
                MacroBreakdownView(
                    viewModel: MacroBreakdownViewModel(macroType: type, entries: viewModel.allEntries)
                ) {
                        selectedMacro = nil
                }
            }
        }
    }
}

#Preview {
    let mockRepo = MockFoodEntryRepository()
    let productRepo = MockFoodProductRepository()
    let _ = mockRepo.foods = FoodEntry.mockList
    ContentView(viewModel: .init(foodRepository: mockRepo), libraryViewModel: .init(repository: productRepo))
}
