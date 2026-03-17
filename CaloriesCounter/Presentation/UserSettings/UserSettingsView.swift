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
                Section {
                    settingRow(label: "Calorías", value: $settings.targetCalories, unit: "kcal", type: .calories, range: 500...10000)
                    settingRow(label: "Proteínas", value: $settings.targetProtein, unit: "g", type: .protein, range: 10...500)
                    settingRow(label: "Carbohidratos", value: $settings.targetCarbs, unit: "g", type: .carbs, range: 10...500)
                    settingRow(label: "Grasas", value: $settings.targetFats, unit: "g", type: .fats, range: 5...300)
                } header: {
                    Text("Metas Diarias")
                } footer: {
                    if !settings.isFormValid {
                        Text("Por favor, introduce valores realistas.")
                            .foregroundColor(.red)
                    }
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
                        .disabled(!settings.isFormValid)
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Cerrar") { focusedField = nil }
                }
            }
        }
    }
    
    private func settingRow(label: String, value: Binding<Double>, unit: String, type: MacroType, range: ClosedRange<Double>) -> some View {
        let isValid = range.contains(value.wrappedValue)
        
        return HStack {
            Label(label, systemImage: iconFor(type))
                .foregroundStyle(isValid ? type.color : .red)
            Spacer()
            TextField("", value: value, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .focused($focusedField, equals: type)
                .frame(width: 80)
                .foregroundColor(isValid ? .primary : .red)
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
