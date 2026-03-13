//
//  CaloriesCounterApp.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 12-03-26.
//

import SwiftUI

@main
struct CaloriesCounterApp: App {
    let mockRepo = MockFoodRepository()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(foodRepository: MockFoodRepository()))
        }
    }
}
