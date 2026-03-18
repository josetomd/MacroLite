//
//  FoodLibraryView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 14-03-26.
//


import SwiftUI

enum LibraryMode {
    case select
    case manage
}

struct FormDestination: Identifiable {
    let id = UUID()
    let product: FoodProduct?
}

struct FoodLibraryView: View {
    @State var viewModel: FoodLibraryViewModel
    var mode: LibraryMode
    var onConfirmEntry: ((FoodEntry) -> Void)?
    @Environment(\.dismiss) var dismiss
    @State private var selectedProduct: FoodProduct?
    @State private var formDestination: FormDestination?

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.filteredProducts.isEmpty {
                    EmptyStateView(
                        icon: "plus.rectangle.on.folder",
                        title: AppStrings.Library.EmptyState.title,
                        message: AppStrings.Library.EmptyState.message,
                        buttonText: AppStrings.Library.EmptyState.button,
                        action: {
                            formDestination = FormDestination(product: nil)
                        }
                    )
                } else {
                    List {
                        ForEach(viewModel.filteredProducts) { product in
                            if mode == .select {
                                Button {
                                    selectedProduct = product
                                } label: {
                                    FoodProductRow(product: product)
                                }
                                .buttonStyle(.plain)
                            } else {
                                Button {
                                    formDestination = FormDestination(product: product)
                                } label: {
                                    FoodProductRow(product: product)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .onDelete(perform: mode == .manage ? deleteProduct : nil)
                    }
                }
            }

            .navigationTitle(mode == .manage ?
                 String(localized: AppStrings.Library.navigationManageModeTitle) :
                 String(localized: AppStrings.Library.navigationSelectModeTitle))
            .searchable(text: $viewModel.searchText)
            .toolbar {
                if mode == .select {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(String(localized: AppStrings.Library.navigationCloseButton)) {
                            dismiss()
                        }
                    }
                } else {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            formDestination = FormDestination(product: nil)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .onChange(of: viewModel.searchText) { _, _ in
                viewModel.performSearch()
            }
            .navigationDestination(item: $selectedProduct) { product in
                let detailVM = FoodDetailViewModel(product: product)

                FoodDetailView(viewModel: detailVM) { entry in
                    onConfirmEntry?(entry)
                    dismiss()
                }
            }
            .sheet(item: $formDestination) { destination in
                let formVM = FoodProductFormViewModel(
                    repository: viewModel.getFoodProductRepository(),
                    product: destination.product
                )
                NavigationStack {
                    FoodProductFormView(viewModel: formVM) {
                        viewModel.loadInitialProducts()
                    }
                }
            }
            .onAppear {
                viewModel.loadInitialProducts()
            }
        }
    }

    private func deleteProduct(at offsets: IndexSet) {
        viewModel.deleteProduct(offsets: offsets)
        viewModel.loadInitialProducts()
    }
}

#Preview {
    let repo = MockFoodProductRepository()
    let viewModel = FoodLibraryViewModel(repository: repo)
    NavigationStack {
        FoodLibraryView(viewModel: viewModel, mode: .manage) { food in
            viewModel.loadInitialProducts()
        }
    }
}

