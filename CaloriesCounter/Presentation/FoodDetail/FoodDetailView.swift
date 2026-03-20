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
    @State private var isShowingDeleteConfirmation = false
    @FocusState private var isAmountFocused: Bool

    var onConfirm: (FoodEntry) -> Void
    var onDelete: ((UUID) -> Void)?

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                LinearGradient(
                    colors: [Color.accentColor.opacity(0.2), Color.accentColor.opacity(0.05)],
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack(spacing: 12) {
                    Image(systemName: "fork.knife.circle.fill")
                        .font(.system(size: 70))
                        .foregroundStyle(Color.accentColor)
                        .shadow(color: .black.opacity(0.1), radius: 10)

                    Text(viewModel.product.name)
                        .font(.title.bold())
                        .multilineTextAlignment(.center)

                    HStack(spacing: 0) {
                        Text("\(Int(viewModel.product.grams))")
                        Text(AppStrings.FoodDetails.gramsPerServing)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
                .padding(.top, 40)
                .padding(.bottom, 30)
            }
            .frame(height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .padding(.horizontal, 10)

            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(AppStrings.FoodDetails.servings)
                            .font(.headline)
                            .padding(.leading, 5)

                        HStack {
                            Button(action: {
                                viewModel.updateAmount(by: -1)
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .font(.system(size: 35))
                                    .foregroundStyle(viewModel.selectedAmount > 1 ? Color.accentColor : .gray)
                            }

                            Spacer()

                            VStack(spacing: 0) {
                                TextField("", value: $viewModel.selectedAmount, formatter: NumberFormatter())
                                    .font(.system(size: 45, weight: .bold, design: .rounded))
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.center)
                                    .focused($isAmountFocused)
                                    .frame(width: 100)
                                    .onSubmit {
                                        if viewModel.selectedAmount < 1 { viewModel.selectedAmount = 1 }
                                    }
                                HStack(spacing: 0) {
                                    Text("= ")

                                    Text("\(Int(viewModel.totalGrams)) ")

                                    Text(AppStrings.FoodDetails.totalGrams)
                                }
                                .font(.subheadline.bold())
                                .foregroundStyle(.secondary)
                                .padding(.top, -5)
                            }

                            Spacer()

                            Button(action: {
                                viewModel.updateAmount(by: 1)
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 35))
                                    .foregroundStyle(Color.accentColor)
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(20)
                    }

                    VStack(alignment: .leading, spacing: 15) {
                        Text(AppStrings.FoodDetails.timeOfDay)
                            .font(.headline)
                            .padding(.leading, 5)

                        Picker("Momento", selection: $viewModel.selectedMealType) {
                            ForEach(MealType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    VStack(spacing: 15) {
                        Text(AppStrings.FoodDetails.totalToBeRegistered)
                            .font(.subheadline.bold())
                            .foregroundStyle(.secondary)

                        HStack(spacing: 20) {
                            nutritionBadge(label: MacroType.calories.label, value: "\(viewModel.product.calories * viewModel.selectedAmount)", color: .primary)
                            nutritionBadge(label: MacroType.protein.label, value: "\((viewModel.product.proteins * Double(viewModel.selectedAmount)).formatted())g", color: .purple)
                            nutritionBadge(label: "Carbs", value: "\((viewModel.product.carbohydrates * Double(viewModel.selectedAmount)).formatted())g", color: .blue)
                            nutritionBadge(label: MacroType.fats.label, value: "\((viewModel.product.fats * Double(viewModel.selectedAmount)).formatted())g", color: .orange)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor.opacity(0.05))
                    .cornerRadius(20)
                }
                .padding(20)
            }

            Button {
                let entry = viewModel.createEntry()
                onConfirm(entry)
            } label: {
                HStack {
                    Text(viewModel.isEditingText)
                        .fontWeight(.bold)
                    Image(systemName: "checkmark.circle.fill")
                }
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(18)
                .shadow(color: Color.accentColor.opacity(0.3), radius: 10, y: 5)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)

            if viewModel.isEditing {
                Button(role: .destructive) {
                    if let id = viewModel.entryId {
                        isShowingDeleteConfirmation = true
                    }
                } label: {
                    Text(AppStrings.FoodDetails.delete)
                        .fontWeight(.medium)
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isAmountFocused = false
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { dismiss() } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.left")
                        Text(AppStrings.FoodDetails.navigationBack)
                    }
                }
            }
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    isAmountFocused = false
                    if viewModel.selectedAmount < 1 {
                        viewModel.selectedAmount = 1
                    }
                } label: {
                    Text(AppStrings.FoodDetails.keyboardReady)
                }
                .fontWeight(.bold)
            }
        }
        .alert(String(localized: AppStrings.FoodDetails.alertTitle), isPresented: $isShowingDeleteConfirmation) {
            Button(String(localized: AppStrings.Alert.deleteButton), role: .destructive) {
                onDelete?(viewModel.entryId!)
                dismiss()
            }
            Button(String(localized: AppStrings.Alert.cancelButton), role: .cancel) { }
        } message: {
            Text(AppStrings.FoodDetails.alertMessage)
        }
    }

    private func nutritionBadge(label: LocalizedStringResource, value: String, color: Color) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline)
                .foregroundStyle(color)
            Text(label)
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        FoodDetailView(viewModel: .init(product: .init(name: "Pancake", calories: 200, proteins: 130, carbohydrates: 20, fats: 30, grams: 100))) { entry in

        }
    }
}
