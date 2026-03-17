//
//  EmptyStateView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 16-03-26.
//

import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    let buttonText: String?
    let action: (() -> Void)?

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: icon)
                .font(.system(size: 80))
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.accentColor, Color.accentColor.opacity(0.5)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .padding(.bottom, 10)

            Text(title)
                .font(.title2.bold())
                .multilineTextAlignment(.center)

            Text(message)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            if let buttonText = buttonText, let action = action {
                Button(action: action) {
                    Text(buttonText)
                        .fontWeight(.bold)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
                .padding(.top, 10)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView(
            icon: "fork.knife.circle",
            title: "¿Qué has comido hoy?",
            message: "Tu diario está vacío. Registra tu primera comida para empezar a ver tus macros.",
            buttonText: "Añadir Alimento",
            action: { }
        )
}
