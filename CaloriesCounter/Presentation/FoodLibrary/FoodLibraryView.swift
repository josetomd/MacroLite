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
    var onProductSelected: ((FoodProduct) -> Void)? = nil

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredProducts) { product in
                    productRow(product)
                }
                .onDelete(perform: mode == .manage ? deleteProduct : nil)
            }
            .navigationTitle(mode == .manage ? "Mis Alimentos" : "Seleccionar")
            .searchable(text: $viewModel.searchText)
            .toolbar {
                if mode == .manage {
                    Button(action: {
                        //TODO: - open form
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onChange(of: viewModel.searchText) { newText in
                viewModel.performSearch()
            }
            .navigationDestination(for: FoodProduct.self) { product in
                Text("product details")
            }
        }
    }

    @ViewBuilder
    private func productRow(_ product: FoodProduct) -> some View {
        if mode == .select {
            Button { onProductSelected?(product) } label: {
                FoodProductRow(product: product)
            }
        } else {
            NavigationLink(value: product) {
                FoodProductRow(product: product)
            }
        }
    }

    private func deleteProduct(at offsets: IndexSet) {
        // TODO: - Delete
    }
}

#Preview {
    let repo = MockFoodProductRepository()
    NavigationStack {
        FoodLibraryView(viewModel: .init(repository: repo), mode: .manage) { food in
        }
    }
}

