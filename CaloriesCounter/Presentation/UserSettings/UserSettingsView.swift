//
//  UserSettingsView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 16-03-26.
//

import SwiftUI

struct UserSettingsView: View {
    @Bindable var settings: UserSettings
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: MacroType?

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Metas Diarias")) {
                    settingRow(label: "Calorías", value: $settings.targetCalories, unit: "kcal", type: .calories)
                    settingRow(label: "Proteínas", value: $settings.targetProtein, unit: "g", type: .protein)
                    settingRow(label: "Carbohidratos", value: $settings.targetCarbs, unit: "g", type: .carbs)
                    settingRow(label: "Grasas", value: $settings.targetFats, unit: "g", type: .fats)
                }

                Section {
                    Text("Estas metas definirán el progreso de tus anillos en la pantalla principal.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Ajustes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Hecho") { dismiss() }
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Cerrar") { focusedField = nil }
                }
            }
        }
    }

    private func settingRow(label: String, value: Binding<Double>, unit: String, type: MacroType) -> some View {
        HStack {
            Label(label, systemImage: iconFor(type))
                .foregroundStyle(type.color)
            Spacer()
            TextField("", value: value, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .focused($focusedField, equals: type)
                .frame(width: 80)
            Text(unit)
                .foregroundStyle(.secondary)
        }
    }

    private func iconFor(_ type: MacroType) -> String {
        switch type {
        case .calories: return "flame.fill"
        case .protein: return "p.circle.fill"
        case .carbs: return "c.circle.fill"
        case .fats: return "f.circle.fill"
        }
    }
}


#Preview {
    UserSettingsView(settings: .init())
}
