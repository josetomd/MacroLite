//
//  FoodRowView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 13-03-26.
//

import SwiftUI

struct FoodRowView: View {
    let food: FoodEntry

    var body: some View {
        HStack(spacing: 15) {
            Text("\(food.amount)x")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .frame(width: 35, height: 35)
                .background(Color.secondary.opacity(0.1))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(food.name)
                    .font(.body)
                    .fontWeight(.semibold)

                HStack(spacing: 10) {
                    macroTag(label: "C", value: food.totalCarbs, color: .blue)
                    macroTag(label: "P", value: food.totalProteins, color: .purple)
                    macroTag(label: "G", value: food.totalFats, color: .orange)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("\(food.totalCalories) kcal")
                    .font(.subheadline)
                    .fontWeight(.bold)

                Text("\(food.totalGrams.formatted()) g")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 4)
    }

    private func macroTag(label: String, value: Double, color: Color) -> some View {
        HStack(spacing: 3) {
            Text(label)
                .font(.system(size: 9, weight: .black))
                .foregroundColor(color)
            Text("\(value.formatted())g")
                .font(.system(size: 11))
                .foregroundColor(.primary.opacity(0.8))
        }
    }
}

#Preview {
    FoodRowView(food: .mockList.first!)
}
