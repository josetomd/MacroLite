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
            Color(.systemBackground)
                .ignoresSafeArea()

            LinearGradient(colors: [viewModel.macroType.color.opacity(0.15), .clear], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()

            VStack(spacing: 20) {
                headerSection

                List {
                    ForEach(viewModel.filteredEntries) { entry in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(entry.name).font(.headline)
                                Text(entry.mealType.rawValue).font(.caption).foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text("\(Int(entry.value(for: viewModel.macroType)))\(viewModel.macroType.unit)")
                                .fontWeight(.bold)
                                .foregroundStyle(viewModel.macroType.color)
                        }
                    }
                }
                .listStyle(.plain)
                .background(Color.clear)
            }
        }
    }

    private var headerSection: some View {
        HStack(spacing: 20) {
            ZStack {
                Circle()
                    .stroke(viewModel.macroType.color.opacity(0.2), lineWidth: 10)
                Circle()
                    .trim(from: 0, to: 0.7) // Simulación de progreso
                    .stroke(viewModel.macroType.color, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
            }
            .frame(width: 80, height: 80)

            VStack(alignment: .leading) {
                Text(viewModel.macroType.rawValue)
                    .font(.title.bold())
                Text("Total: \(Int(viewModel.totalValue)) \(viewModel.macroType.unit)")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button(action: onClose) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 25)
        .padding(.top, 20)
    }
}

#Preview {
    MacroBreakdownView(viewModel: .init(macroType: .calories, entries: FoodEntry.mockList)) {

    }
}
