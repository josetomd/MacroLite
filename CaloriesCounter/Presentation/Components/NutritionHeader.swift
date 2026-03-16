//
//  NutritionHeader.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 13-03-26.
//

import SwiftUI

struct NutritionHeader: View {
    let summary: NutritionSummary
    @Binding var selectedMacro: MacroType?
    var body: some View {
        VStack(spacing: 25) {
            MacroStatView(
                title: "Calorías Totales",
                value: Double(summary.totalCalories),
                goal: summary.caloriesGoal,
                color: .primary,
                unit: "kcal"
            )
            .onTapGesture { selectedMacro = .calories }
            .scaleEffect(1.5)
            .padding(.vertical, 20)

            HStack(spacing: 25) {
                MacroStatView(title: "Carbs", value: summary.totalCarbs, goal: summary.carbsGoal, color: .blue, unit: "g")
                    .onTapGesture { selectedMacro = .carbs }
                MacroStatView(title: "Proteína", value: summary.totalProteins, goal: summary.proteinGoal, color: .purple, unit: "g")
                    .onTapGesture { selectedMacro = .protein }
                MacroStatView(title: "Grasas", value: summary.totalFats, goal: summary.fatGoal, color: .orange, unit: "g")
                    .onTapGesture { selectedMacro = .fats }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 25).fill(Color(.systemBackground)))
        .shadow(color: .black.opacity(0.05), radius: 15)
    }
}
#Preview {
    @Previewable @State var selectedMacro: MacroType? = nil
    NutritionHeader(summary: .init(totalCalories: 1500, totalCarbs: 140, totalProteins: 65, totalFats: 25), selectedMacro: $selectedMacro)
}
