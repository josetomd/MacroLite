//
//  MockHapticManager.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 20-03-26.
//

import SwiftUI

class MockHapticManager: HapticProvider {
    func triggerNotification(type: UINotificationFeedbackGenerator.FeedbackType) { }
    func triggerImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) { }
}
