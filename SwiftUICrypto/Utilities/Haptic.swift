//
//  Haptic.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 24/06/26.
//

import Foundation
import UIKit

class HapticManager {
    static let generator = UINotificationFeedbackGenerator()
    
    static func play(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
