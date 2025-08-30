//
//   WelcomePresenter.swift
//  Recipes App
//
//  Created by Aziza Azizova on 22/08/25.
//

import UIKit

protocol WelcomePresenterProtocol {
    var shouldShowOnboarding: Bool { get }
}

final class WelcomePresenter: WelcomePresenterProtocol {
    var shouldShowOnboarding: Bool {
        !UserDefaults.standard.hasSeenOnboarding
    }
}

