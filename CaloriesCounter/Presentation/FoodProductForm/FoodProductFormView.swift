//
//  FoodProductFormView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 15-03-26.
//

import SwiftUI

struct FoodProductFormView: View {
    @State var viewModel: FoodProductFormViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                LinearGradient(
                    colors: [Color.orange.opacity(0.2), Color.orange.opacity(0.05)],
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack(spacing: 15) {
                    Image(systemName: "pencil.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(Color.orange)

                    TextField("Nombre del alimento", text: $viewModel.name)
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.plain)
                        .padding(.horizontal)

                    HStack {
                        Text("Base:")
                        TextField("100", text: $viewModel.grams)
                            .frame(width: 50)
                            .keyboardType(.numberPad)
                        Text("g")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
                .padding(.vertical, 30)
            }
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding(.horizontal, 10)

            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    Text("Información Nutricional")
                        .font(.headline)
                        .padding(.leading, 5)

                    VStack(spacing: 20) {
                        editableMacroRow(label: "Calorías (kcal)", value: $viewModel.calories, icon: "flame.fill", color: .red)
                        Divider()
                        editableMacroRow(label: "Proteínas (g)", value: $viewModel.proteins, icon: "p.circle.fill", color: .purple)
                        Divider()
                        editableMacroRow(label: "Carbohidratos (g)", value: $viewModel.carbs, icon: "c.circle.fill", color: .blue)
                        Divider()
                        editableMacroRow(label: "Grasas (g)", value: $viewModel.fats, icon: "f.circle.fill", color: .orange)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)
                }
                .padding(20)
            }

            Button {
                // TODO: - Save food
                dismiss()
            } label: {
                Text("Guardar en Catálogo")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.name.isEmpty ? Color.gray : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(18)
            }
            .disabled(viewModel.name.isEmpty)
            .padding()
        }
    }

    private func editableMacroRow(label: String, value: Binding<String>, icon: String, color: Color) -> some View {
        HStack {
            Label(label, systemImage: icon)
                .foregroundStyle(color)
            Spacer()
            TextField("0", text: value)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .font(.headline)
        }
    }
}

#Preview {
    FoodProductFormView(viewModel: FoodProductFormViewModel(repository: MockFoodProductRepository()))
}
