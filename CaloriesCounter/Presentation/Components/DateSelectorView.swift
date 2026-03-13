//
//  DateSelectorView.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 13-03-26.
//

import SwiftUI
import Foundation

struct DateSelectorView: View {
    @Binding var selectedDate: Date

    var body: some View {
        HStack(spacing: 20) {
            Button {
                moveDate(by: -1)
            } label: {
                Image(systemName: "chevron.left")
                    .fontWeight(.bold)
            }

            Text(selectedDate.formatted(date: .abbreviated, time: .omitted))
                .font(.headline)
                .frame(width: 120)

            Button {
                moveDate(by: 1)
            } label: {
                Image(systemName: "chevron.right")
                    .fontWeight(.bold)
            }
        }
    }

    private func moveDate(by days: Int) {
        if let newDate = Calendar.current.date(byAdding: .day, value: days, to: selectedDate) {
            selectedDate = newDate
        }
    }
}

#Preview {
    @Previewable @State var date: Date = .now
    DateSelectorView(selectedDate: $date)
}
