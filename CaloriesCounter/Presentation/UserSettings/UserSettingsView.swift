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
                    settingRow(label: MacroType.calories.label, value: $settings.targetCalories, unit: "kcal", type: .calories, range: 500...10000)
                    settingRow(label: MacroType.protein.label, value: $settings.targetProtein, unit: "g", type: .protein, range: 10...500)
                    settingRow(label: MacroType.carbs.label, value: $settings.targetCarbs, unit: "g", type: .carbs, range: 10...500)
                    settingRow(label: MacroType.fats.label, value: $settings.targetFats, unit: "g", type: .fats, range: 5...300)
                } header: {
                    Text(AppStrings.Settings.dailyGoals)
                } footer: {
                    if !settings.isFormValid {
                        Text(AppStrings.Settings.validation)
                            .foregroundColor(.red)
                    }
                }
                
                Section {
                    Text(AppStrings.Settings.goalsDescription)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle(String(localized: AppStrings.Settings.Navigation.title))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(String(localized: AppStrings.Settings.Navigation.done)) { dismiss() }
                        .disabled(!settings.isFormValid)
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(String(localized: AppStrings.Settings.Navigation.close)) { focusedField = nil }
                }
            }
        }
    }
    
    private func settingRow(label: LocalizedStringResource, value: Binding<Double>, unit: String, type: MacroType, range: ClosedRange<Double>) -> some View {
        let isValid = range.contains(value.wrappedValue)
        
        return HStack {
            Label(String(localized: label), systemImage: iconFor(type))
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
