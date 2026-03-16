//
//  MealSectionView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 13-03-26.
//

import SwiftUI

struct MealSectionView: View {
    let title: String
    let entries: [FoodEntry]
    @Binding var selectedEntry: FoodEntry?
    var totalCalories: Int {
        entries.reduce(0) { $0 + $1.calories }
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
                    Text("No hay registros")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ForEach(entries) { food in
                        FoodRowView(food: food)
                            .onTapGesture {
                                selectedEntry = food
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
        }
        .padding(.horizontal)
    }
}

#Preview {
    @Previewable @State var selectedEntry: FoodEntry? = FoodEntry.mockList.first!
    MealSectionView(title: "Breakfast", entries: FoodEntry.mockList, selectedEntry: $selectedEntry)
}
