//
//  FoodProductRow.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 14-03-26.
//


import SwiftUI

struct FoodProductRow: View {
    let product: FoodProduct
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.accentColor.opacity(0.1))
                    .frame(width: 45, height: 45)
                
                Image(systemName: "fork.knife")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 18))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                    .lineLimit(1)
                
                HStack(spacing: 12) {
                    macroLabel(label: "C", value: product.carbohydrates, color: .blue)
                    macroLabel(label: "P", value: product.proteins, color: .purple)
                    macroLabel(label: "G", value: product.fats, color: .orange)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(product.calories) kcal")
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                HStack(spacing: 0) {
                    Text(AppStrings.FoodProductRow.per)
                    Text(" \(Int(product.grams)) ")
                    Text("g")
                }
                .font(.caption2)
                .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }

    private func macroLabel(label: String, value: Double, color: Color) -> some View {
        HStack(spacing: 3) {
            Text(label)
                .font(.system(size: 9, weight: .black))
                .foregroundColor(color)
            Text("\(value.formatted())g")
                .font(.system(size: 11))
                .foregroundColor(.primary.opacity(0.8))
        }
    }
}

#Preview {
    List {
        FoodProductRow(product: FoodProduct(
            name: "Salmón",
            calories: 208,
            proteins: 20,
            carbohydrates: 0,
            fats: 13,
            grams: 100
        ))
    }
}
