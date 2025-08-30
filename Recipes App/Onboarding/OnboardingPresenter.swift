//
//  OnboardingPresenter.swift
//  Recipes App
//
//  Created by Aziza Azizova on 22/08/25.
//

import UIKit

protocol OnboardingPresenterProtocol {
    var slides: [OnboardingSlide] { get }
    func getSlide(at index: Int) -> OnboardingSlide
    func isLastSlide(index: Int) -> Bool
    func markOnboardingSeen()
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    private(set) var slides: [OnboardingSlide] = [
        OnboardingSlide(title: "Recipes from\nall over the \nWorld", imageName: "onboarding2"),
        OnboardingSlide(title: "Recipes with \neach and every \ndetail", imageName: "onboarding3"),
        OnboardingSlide(title: "Cook it now or \nsave it for later", imageName: "onboarding4")
    ]

    func getSlide(at index: Int) -> OnboardingSlide {
        slides[index]
    }

    func isLastSlide(index: Int) -> Bool {
        index == slides.count - 1
    }

    func markOnboardingSeen() {
        UserDefaults.standard.hasSeenOnboarding = true
    }
}
