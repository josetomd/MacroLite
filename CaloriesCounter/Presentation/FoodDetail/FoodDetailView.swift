//
//  FoodDetailView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 14-03-26.
//


import SwiftUI

struct FoodDetailView: View {
    @State var viewModel: FoodDetailViewModel
    @Environment(\.dismiss) var dismiss

    var onConfirm: (FoodEntry) -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                VStack(spacing: 8) {
                    Text(viewModel.product.name)
                        .font(.title.bold())
                    
                    Text("\(viewModel.product.calories) kcal por unidad")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top)

                VStack {
                    Text("Cantidad")
                        .font(.headline)
                    
                    HStack(spacing: 20) {
                        Button(action: { if viewModel.selectedAmount > 1 { viewModel.selectedAmount -= 1 } }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.system(size: 32))
                        }
                        
                        Text("\(viewModel.selectedAmount)")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .frame(minWidth: 60)
                        
                        Button(action: { viewModel.selectedAmount += 1 }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 32))
                        }
                    }
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(15)
                }

                Picker("Meal", selection: $viewModel.selectedMealType) {
                    ForEach(MealType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                Spacer()

                HStack(spacing: 30) {
                    summaryItem(label: "Calorías", value: "\(viewModel.product.calories * viewModel.selectedAmount)")
                    summaryItem(label: "Grasas", value: "\(Int(viewModel.product.grams * Double(viewModel.selectedAmount)))g")
                    summaryItem(label: "Carbs", value: "\(Int(viewModel.product.carbohydrates * Double(viewModel.selectedAmount)))g")
                    summaryItem(label: "Proteins", value: "\(Int(viewModel.product.proteins * Double(viewModel.selectedAmount)))g")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor.opacity(0.05))
                .cornerRadius(12)
                .padding(.horizontal)

                Button {
                    let newEntry = viewModel.createEntry()
                    onConfirm(newEntry)
                    dismiss()
                } label: {
                    Text("Añadir al Diario")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(15)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
    
    private func summaryItem(label: String, value: String) -> some View {
        VStack {
            Text(value)
                .font(.headline)
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    FoodDetailView(viewModel: .init(product: .init(name: "Pancake", calories: 200, proteins: 130, carbohydrates: 20, fats: 30, grams: 100))) { entry in

    }
}
