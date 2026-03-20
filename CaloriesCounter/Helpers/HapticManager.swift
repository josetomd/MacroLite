//
//  HapticManager.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 19-03-26.
//

import Foundation
import SwiftUI

class HapticManager: HapticProvider {
    static let shared = HapticManager()

    private init() { }

    func triggerNotification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
    func triggerImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
