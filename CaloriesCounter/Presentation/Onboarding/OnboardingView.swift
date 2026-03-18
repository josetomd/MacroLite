//
//  OnboardingView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 16-03-26.
//

import SwiftUI

struct OnboardingView: View {
    @Bindable var settings: UserSettings
    @Binding var shouldShowOnboarding: Bool
    @State private var currentPage = 0
    @FocusState private var focusedField: Bool

    var isFormValid: Bool {
        settings.targetCalories >= 500 && settings.targetCalories <= 10000 &&
        settings.targetProtein >= 10 &&
        settings.targetCarbs >= 10 &&
        settings.targetFats >= 5
    }

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            TabView(selection: $currentPage) {
                onboardingStep(
                    title: AppStrings.Onboarding.welcomeTitle,
                    subtitle: AppStrings.Onboarding.welcomeSubtitle ,
                    icon: "sparkles",
                    color: .orange
                ).tag(0)

                goalsConfigStep.tag(1)

                onboardingStep(
                    title: AppStrings.Onboarding.readyTitle,
                    subtitle: AppStrings.Onboarding.readySubtitle,
                    icon: "checkmark.circle.fill",
                    color: .green
                ).tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))

            VStack {
                Spacer()
                buttonAction
            }
            .padding(30)
            .padding(.bottom, 30)
        }
        .onChange(of: currentPage) { focusedField = false }
    }

    private var goalsConfigStep: some View {
        VStack(spacing: 20) {
            Text(AppStrings.Onboarding.goalsTitle)
                .font(.title.bold())

            Text(AppStrings.Onboarding.goalsSubtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            VStack(spacing: 12) {
                macroInput(label: MacroType.calories.label, value: $settings.targetCalories, unit: "kcal", color: .red, range: 500...10000)
                macroInput(label: MacroType.protein.label, value: $settings.targetProtein, unit: "g", color: .purple, range: 10...500)
                macroInput(label: MacroType.carbs.label, value: $settings.targetCarbs, unit: "g", color: .blue, range: 10...1000)
                macroInput(label: MacroType.fats.label, value: $settings.targetFats, unit: "g", color: .orange, range: 5...300)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(20)

            Button {
                withAnimation {
                    settings.targetCalories = 2000
                    settings.targetProtein = 150
                    settings.targetCarbs = 250
                    settings.targetFats = 70
                }
            } label: {
                Label(String(localized: AppStrings.Onboarding.standardValuesButton), systemImage: "arrow.counterclockwise")
            }
            .padding(.top, 5)

            if !isFormValid {
                Text(AppStrings.Onboarding.validationError)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .transition(.opacity)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 80)
    }

    private func macroInput(label: LocalizedStringResource, value: Binding<Double>, unit: String, color: Color, range: ClosedRange<Double>) -> some View {
        let isValid = range.contains(value.wrappedValue)

        return HStack {
            Text(label)
                .bold()
                .foregroundStyle(isValid ? color : .red)
            Spacer()
            TextField("", value: value, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .focused($focusedField)
                .frame(width: 80)
                .foregroundColor(isValid ? .primary : .red)
            Text(unit)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var buttonAction: some View {
        Button {
            if currentPage < 2 {
                withAnimation { currentPage += 1 }
            } else {
                shouldShowOnboarding = false
            }
        } label: {
            Text(currentPage == 2 ?
                 AppStrings.Onboarding.startButton :
                    AppStrings.Onboarding.nextButton)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(currentPage == 1 && !isFormValid ? Color.gray : Color.orange)
                .foregroundColor(.white)
                .cornerRadius(15)
        }
        .disabled(currentPage == 1 && !isFormValid)
    }

        private func onboardingStep(
                    title: LocalizedStringResource,
                    subtitle: LocalizedStringResource,
                    icon: String,
                    color: Color
        ) -> some View {
            VStack(spacing: 20) {
                Image(systemName: icon)
                    .font(.system(size: 80))
                    .foregroundStyle(color)
                Text(title)
                    .font(.largeTitle.bold())
                Text(subtitle)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            .padding(.bottom, 100)
        }
}

#Preview("English") {
    OnboardingView(settings: .init(), shouldShowOnboarding: .constant(true))
        .environment(\.locale, .init(identifier: "en"))
}

#Preview("Spanish") {
    OnboardingView(settings: .init(), shouldShowOnboarding: .constant(true))
        .environment(\.locale, .init(identifier: "es"))
}
