//
//  NutritionHeader.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 13-03-26.
//

import SwiftUI

struct NutritionHeader: View {
    let summary: NutritionSummary

    var body: some View {
        VStack(spacing: 25) {
            MacroStatView(
                title: "Calorías Totales",
                value: Double(summary.totalCalories),
                goal: summary.caloriesGoal,
                color: .primary,
                unit: "kcal"
            )
            .scaleEffect(1.5)
            .padding(.vertical, 20)

            HStack(spacing: 25) {
                MacroStatView(title: "Carbs", value: summary.totalCarbs, goal: summary.carbsGoal, color: .blue, unit: "g")
                MacroStatView(title: "Proteína", value: summary.totalProteins, goal: summary.proteinGoal, color: .purple, unit: "g")
                MacroStatView(title: "Grasas", value: summary.totalFats, goal: summary.fatGoal, color: .orange, unit: "g")
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 25).fill(Color(.systemBackground)))
        .shadow(color: .black.opacity(0.05), radius: 15)
    }
}
#Preview {
    NutritionHeader(summary: .init(totalCalories: 1500, totalCarbs: 140, totalProteins: 65, totalFats: 25))
}
