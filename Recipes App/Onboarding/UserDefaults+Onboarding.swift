//
//  UserDefaults+Onboarding.swift
//  Recipes App
//
//  Created by Aziza Azizova on 19/08/25.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let hasSeenOnboarding = "hasSeenOnboarding"
    }

    var hasSeenOnboarding: Bool {
        get { bool(forKey: Keys.hasSeenOnboarding) }
        set { set(newValue, forKey: Keys.hasSeenOnboarding) }
    }
}
