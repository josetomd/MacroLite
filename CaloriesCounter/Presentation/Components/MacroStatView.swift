//
//  MacroStatView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 13-03-26.
//


import SwiftUI

struct MacroStatView: View {
    let title: String
    let value: Double
    let goal: Double
    let color: Color
    
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
                    .rotationEffect(.degrees(-90)) // Empezar arriba
                    .animation(.spring, value: value)
                
                Text("\(Int(value))g")
                    .font(.caption)
                    .fontWeight(.bold)
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
    MacroStatView(title: "Carbohidratos", value: 250, goal: 340, color: .blue)
}
