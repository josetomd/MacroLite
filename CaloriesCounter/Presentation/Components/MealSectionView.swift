//
//  MealSectionView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 13-03-26.
//

import SwiftUI

struct MealSectionView: View {
    @State private var isShowingDeleteConfirmation = false
    @State private var selectedID: UUID?
    let title: LocalizedStringResource
    let entries: [FoodEntry]
    @Binding var selectedEntry: FoodEntry?

    var onAdd: () -> Void
    var onDelete: (UUID) -> Void
    var totalCalories: Int {
        entries.reduce(0) { $0 + ($1.calories * Int($1.amount)) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Text("\(totalCalories) kcal")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)

            VStack(spacing: 0) {
                if entries.isEmpty {
                    Text(AppStrings.MealSection.emptyTitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ForEach(entries) { food in
                        FoodRowView(food: food)
                            .onTapGesture {
                                selectedEntry = food
                            }
                            .contextMenu {
                                Button {
                                    selectedEntry = food
                                } label: {
                                    Label(String(localized: AppStrings.MealSection.menuEditTitle), systemImage: "pencil")
                                }

                                Button(role: .destructive) {
                                    isShowingDeleteConfirmation = true
                                    selectedID = food.id
                                } label: {
                                    Label(String(localized: AppStrings.MealSection.menuDeleteTitle), systemImage: "trash")
                                }
                            }
                        if food.id != entries.last?.id {
                            Divider().padding(.leading, 0)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical, 8)
            .background(Color(.secondarySystemBackground).opacity(0.5))
            .cornerRadius(12)
            .alert(String(localized: AppStrings.FoodDetails.alertTitle), isPresented: $isShowingDeleteConfirmation) {
                Button(String(localized: AppStrings.Alert.deleteButton), role: .destructive) {
                    onDelete(selectedID!)
                    selectedID = nil
                }
                Button(String(localized: AppStrings.Alert.cancelButton), role: .cancel) { }
            } message: {
                Text(AppStrings.FoodDetails.alertMessage)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    @Previewable @State var selectedEntry: FoodEntry? = FoodEntry.mockList.first!
    MealSectionView(title: AppStrings.MealType.breakfast, entries: FoodEntry.mockList, selectedEntry: $selectedEntry) { _ in }
}
