//
//  MacroBreakdownView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 16-03-26.
//

import SwiftUI

struct MacroBreakdownView: View {
    let viewModel: MacroBreakdownViewModel
    var onClose: () -> Void

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()

            LinearGradient(
                colors: [viewModel.macroType.color.opacity(0.2), .clear],
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                headerSection
                    .padding(.bottom, 30)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        HStack {
                            Text("Fuentes principales")
                                .font(.headline)
                            Spacer()
                            Text("\(viewModel.filteredEntries.count) registros")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal, 25)

                        VStack(spacing: 12) {
                            ForEach(viewModel.filteredEntries) { entry in
                                MacroBreakdownRow(
                                    entry: entry,
                                    macroType: viewModel.macroType,
                                    maxTotalValue: viewModel.totalValue,
                                    animFactor: viewModel.appearanceProgress
                                )
                            }
                        }
                        .padding(.horizontal, 20)

                        Color.clear.frame(height: 100)
                    }
                }
            }
        }
    }

    private var headerSection: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .bold))
                        .padding(10)
                        .background(.secondary.opacity(0.2))
                        .clipShape(Circle())
                        .foregroundStyle(.primary)
                }
            }
            .padding(.horizontal, 25)

            HStack(spacing: 25) {
                ZStack {
                    Circle()
                        .stroke(viewModel.macroType.color.opacity(0.1), lineWidth: 12)

                    Circle()
                        .trim(from: 0, to: viewModel.completionPercentage * viewModel.appearanceProgress)
                        .stroke(
                            viewModel.macroType.color,
                            style: StrokeStyle(lineWidth: 12, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))

                    Image(systemName: iconForMacro(viewModel.macroType))
                        .font(.title2)
                        .foregroundStyle(viewModel.macroType.color)
                        .opacity(viewModel.appearanceProgress)
                }
                .frame(width: 90, height: 90)
                .shadow(color: viewModel.macroType.color.opacity(0.3 * viewModel.appearanceProgress), radius: 10)
                .onAppear {
                    withAnimation(.spring(response: 1.0, dampingFraction: 0.7)) {
                        viewModel.appearanceProgress = 1.0
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.macroType.rawValue.uppercased())
                        .font(.caption)
                        .bold()
                        .tracking(2)
                        .foregroundStyle(.secondary)

                    Text("\(Int(viewModel.totalValue))")
                        .font(.system(size: 40, weight: .black, design: .rounded))

                    Text(viewModel.macroType.unit)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(.horizontal, 30)
        }
        .padding(.top, 10)
    }

    private func iconForMacro(_ type: MacroType) -> String {
        switch type {
        case .calories: return "flame.fill"
        case .protein: return "leaf.fill"
        case .carbs: return "fork.knife"
        case .fats: return "drop.fill"
        }
    }
}

struct MacroBreakdownRow: View {
    let entry: FoodEntry
    let macroType: MacroType
    let maxTotalValue: Double
    let animFactor: Double

    var body: some View {
        let value = entry.value(for: macroType)
        let percentage = maxTotalValue > 0 ? (value / maxTotalValue) : 0

        VStack(spacing: 8) {
            HStack(alignment: .center) {
                Text("\(entry.amount)x")
                    .font(.caption.bold())
                    .padding(6)
                    .background(macroType.color.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(macroType.color)

                VStack(alignment: .leading, spacing: 2) {
                    Text(entry.name)
                        .font(.subheadline.bold())
                    Text(entry.mealType.rawValue)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("\(Int(value))\(macroType.unit)")
                    .font(.system(.subheadline, design: .rounded))
                    .bold()
                    .foregroundStyle(macroType.color)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.secondary.opacity(0.1))

                    Capsule()
                        .fill(macroType.color)
                        .frame(width: geo.size.width * CGFloat(percentage) * CGFloat(animFactor))
                }
            }
            .frame(height: 6)
        }
        .padding()
        .background(Color(.secondarySystemBackground).opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}


#Preview {
    MacroBreakdownView(viewModel: .init(macroType: .calories, entries: FoodEntry.mockList, target: 2000)) {

    }
}
