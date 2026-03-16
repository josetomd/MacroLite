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

struct FoodLibraryView: View {
    @State var viewModel: FoodLibraryViewModel
    var mode: LibraryMode
    var onConfirmEntry: ((FoodEntry) -> Void)?
    @Environment(\.dismiss) var dismiss
    @State private var selectedProduct: FoodProduct?
    @State private var isShowingForm = false

    var body: some View {
        NavigationStack {
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
                        // TODO: - Navigate to Edit product
                        FoodProductRow(product: product)
                    }
                }
                .onDelete(perform: mode == .manage ? deleteProduct : nil)
            }
            .navigationTitle(mode == .manage ? "Mis Alimentos" : "Seleccionar")
            .searchable(text: $viewModel.searchText)
            .toolbar {
                if mode == .select {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cerrar") {
                            dismiss()
                        }
                    }
                } else {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isShowingForm = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .onChange(of: viewModel.searchText) { newText in
                viewModel.performSearch()
            }
            .navigationDestination(item: $selectedProduct) { product in
                let detailVM = FoodDetailViewModel(product: product)

                FoodDetailView(viewModel: detailVM) { entry in
                    onConfirmEntry?(entry)
                    dismiss()
                }
            }
            .sheet(isPresented: $isShowingForm) {
                let formVM = FoodProductFormViewModel(repository: viewModel.getFoodProductRepository())

                FoodProductFormView(viewModel: formVM) {
                    viewModel.loadInitialProducts()
                }
            }
        }
    }

    private func deleteProduct(at offsets: IndexSet) {
        // TODO: - Delete
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

