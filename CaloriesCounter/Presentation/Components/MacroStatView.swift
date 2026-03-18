//
//  MacroStatView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 13-03-26.
//


import SwiftUI

struct MacroStatView: View {
    let title: LocalizedStringResource
    let value: Double
    let goal: Double
    let color: Color
    let unit: String

    private var progress: Double {
        guard goal > 0 else { return 0 }
        return value / goal
    }

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .stroke(color.opacity(0.2), lineWidth: 6)

                Circle()
                    .trim(from: 0, to: CGFloat(min(progress, 1.0)))
                    .stroke(color, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.spring, value: value)

                VStack(spacing: 0) {
                    Text("\(value.formatted())")
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.bold)
                    Text(unit)
                        .font(.system(size: 8))
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: 60, height: 60)

            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
                .textCase(.uppercase)
        }
    }
}

#Preview {
    MacroStatView(title: "Carbohidratos", value: 250, goal: 340, color: .blue, unit: "g")
}
