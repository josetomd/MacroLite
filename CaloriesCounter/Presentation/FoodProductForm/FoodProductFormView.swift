//
//  FoodProductFormView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 15-03-26.
//

import SwiftUI

enum Field: Hashable {
    case name, grams, calories, proteins, carbs, fats
}

struct FoodProductFormView: View {
    @State var viewModel: FoodProductFormViewModel
    @State private var isShowingDeleteConfirmation = false
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Field?

    var onSave: () -> Void

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
                        .focused($focusedField, equals: .name)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.sentences)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .grams
                        }

                    HStack {
                        Text("Base:")
                        TextField("100", text: $viewModel.grams)
                            .frame(width: 50)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .grams)
                            .autocorrectionDisabled(true)
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
                        editableMacroRow(label: "Calorías (kcal)",
                                         value: $viewModel.calories,
                                         icon: "flame.fill",
                                         color: .red,
                                         field: .calories)
                        Divider()
                        editableMacroRow(label: "Proteínas (g)",
                                         value: $viewModel.proteins,
                                         icon: "p.circle.fill",
                                         color: .purple,
                                         field: .proteins)
                        Divider()
                        editableMacroRow(label: "Carbohidratos (g)",
                                         value: $viewModel.carbs,
                                         icon: "c.circle.fill",
                                         color: .blue,
                                         field: .carbs)
                        Divider()
                        editableMacroRow(label: "Grasas (g)",
                                         value: $viewModel.fats,
                                         icon: "f.circle.fill",
                                         color: .orange,
                                         field: .fats)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)
                }
                .padding(20)
            }

            Button {
                viewModel.save()
                onSave()
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

            if viewModel.isEditing {
                Button(role: .destructive) {
                    isShowingDeleteConfirmation = true
                } label: {
                    Label("Eliminar Alimento", systemImage: "trash")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .padding(.horizontal)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                HStack(spacing: 20) {
                    Button(action: goToPreviousField) {
                        Image(systemName: "chevron.up")
                    }
                    .disabled(focusedField == .name)

                    Button(action: goToNextField) {
                        Image(systemName: "chevron.down")
                    }
                    .disabled(focusedField == .fats)
                }

                Spacer()

                Button(focusedField == .fats ? "Listo" : "Siguiente") {
                    if focusedField == .fats {
                        focusedField = nil
                    } else {
                        goToNextField()
                    }
                }
                .fontWeight(.bold)
            }
        }
        .alert("¿Eliminar Alimento?", isPresented: $isShowingDeleteConfirmation) {
            Button("Eliminar", role: .destructive) {
                viewModel.delete()
                onSave()
                dismiss()
            }
            Button("Cancelar", role: .cancel) { }
        } message: {
            Text("Esta acción no se puede deshacer. El alimento desaparecerá de tu catálogo.")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            focusedField = nil
        }
    }

    private func editableMacroRow(label: String, value: Binding<String>, icon: String, color: Color, field: Field) -> some View {
        HStack {
            Label(label, systemImage: icon)
                .foregroundStyle(color)
            Spacer()
            TextField("0", text: value)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .font(.headline)
                .focused($focusedField, equals: field)
                .autocorrectionDisabled(true)
        }
    }
    private func goToNextField() {
        switch focusedField {
        case .name: focusedField = .grams
        case .grams: focusedField = .calories
        case .calories: focusedField = .proteins
        case .proteins: focusedField = .carbs
        case .carbs: focusedField = .fats
        default: focusedField = nil
        }
    }

    private func goToPreviousField() {
        switch focusedField {
        case .fats: focusedField = .carbs
        case .carbs: focusedField = .proteins
        case .proteins: focusedField = .calories
        case .calories: focusedField = .grams
        case .grams: focusedField = .name
        default: focusedField = nil
        }
    }
}

#Preview {
    FoodProductFormView(viewModel: FoodProductFormViewModel(repository: MockFoodProductRepository())) {

    }
}
