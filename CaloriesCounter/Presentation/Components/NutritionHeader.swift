//
//  NutritionHeader.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 13-03-26.
//

import SwiftUI

struct NutritionHeader: View {
    var totalCalories: Int
    var totalCarbs: Double
    var totalProteins: Double
    var totalFats: Double

    let calorieGoal: Double = 2500
    let carbsGoal: Double = 250
    let proteinGoal: Double = 140
    let fatGoal: Double = 70

    var body: some View {
        VStack(spacing: 25) {
            MacroStatView(
                title: "Calorías Totales",
                value: Double(totalCalories),
                goal: calorieGoal,
                color: .primary,
                unit: "kcal"
            )
            .scaleEffect(1.5)
            .padding(.vertical, 20)

            HStack(spacing: 25) {
                MacroStatView(title: "Carbs", value: totalCarbs, goal: carbsGoal, color: .blue, unit: "g")
                MacroStatView(title: "Proteína", value: totalProteins, goal: proteinGoal, color: .purple, unit: "g")
                MacroStatView(title: "Grasas", value: totalFats, goal: fatGoal, color: .orange, unit: "g")
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 25).fill(Color(.systemBackground)))
        .shadow(color: .black.opacity(0.05), radius: 15)
    }
}
#Preview {
    NutritionHeader(totalCalories: 2000, totalCarbs: 250, totalProteins: 140, totalFats: 40)
}
