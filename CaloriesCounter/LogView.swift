//
//  LogView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 12-03-26.
//

import SwiftUI

struct LogView: View {
    @State var viewModel: FoodListViewModel
    @State private var isShowingLibrary = false
    @State private var entryToEdit: FoodEntry?
    @State private var selectedMacro: MacroType?
    @State private var selectedMealType: MealType?
    @State private var settings = UserSettings()
    @State private var isFloating = false
    @State private var showingSettings = false
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false

    @State private var libraryViewModel: FoodLibraryViewModel
    init(viewModel: FoodListViewModel, libraryViewModel: FoodLibraryViewModel) {
        self._libraryViewModel = State(initialValue: libraryViewModel)
        self._viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            NavigationStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        NutritionHeader(summary: viewModel.nutritionSummary, selectedMacro: $selectedMacro)
                        if viewModel.allEntries.isEmpty {
                            EmptyStateView(
                                icon: "fork.knife.circle",
                                title: AppStrings.Log.EmptyState.title,
                                message: AppStrings.Log.EmptyState.message,
                                buttonText: AppStrings.Log.EmptyState.button,
                                action: { isShowingLibrary = true }
                            )
                        } else {
                            LazyVStack(spacing: 20) {
                                ForEach(MealType.allCases, id: \.self) { mealType in
                                    MealSectionView(
                                        title: mealType.label,
                                        entries: viewModel.groupedFoods[mealType] ?? [],
                                        selectedEntry: $entryToEdit,
                                        onAdd: {
                                            libraryViewModel.preSelectedMealType = mealType
                                            self.isShowingLibrary = true
                                        },
                                        onDelete: { id in
                                            viewModel.deleteEntry(id: id)
                                        })

                                }
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.userSettings = settings
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
                    FoodLibraryView(viewModel: libraryViewModel, selectedMealType: selectedMealType) { newEntry in
                        viewModel.addEntry(newEntry)
                    }
                    .id(selectedMealType)
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        DateSelectorView(selectedDate: $viewModel.selectedDate)
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showingSettings = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .foregroundStyle(.secondary)
                        }
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
                        entryToEdit?.amount = updatedEntry.amount
                        entryToEdit?.mealType = updatedEntry.mealType
                        viewModel.updateEntry(updatedEntry)
                        entryToEdit = nil
                    } onDelete: { id in
                        viewModel.deleteEntry(id: id)
                        entryToEdit = nil
                    }
                }
                .sheet(isPresented: $showingSettings) {
                    UserSettingsView(settings: settings)
                        .onDisappear {
                            viewModel.userSettings = settings
                        }
                }
            }
            .fullScreenCover(isPresented: .init(
                get: { !hasCompletedOnboarding },
                set: { hasCompletedOnboarding = !$0 }
            )) {
                OnboardingView(settings: settings, shouldShowOnboarding: .init(
                    get: { !hasCompletedOnboarding },
                    set: { hasCompletedOnboarding = !$0 }
                ))
            }

            if let type = selectedMacro {
                let targetGoal = switch type {
                case .calories: settings.targetCalories
                case .protein: settings.targetProtein
                case .carbs: settings.targetCarbs
                case .fats: settings.targetFats
                }
                MacroBreakdownView(
                    viewModel: MacroBreakdownViewModel(macroType: type, entries: viewModel.allEntries, target: targetGoal)
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
    LogView(viewModel: .init(foodRepository: mockRepo), libraryViewModel: .init(repository: productRepo, mode: .manage))
}
