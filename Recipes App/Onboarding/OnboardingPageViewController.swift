//
//  OnboardingPageViewController.swift
//  Recipes App
//
//  Created by Aziza Azizova on 20/08/25.
//

import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    private var slides: [OnboardingSlide] = []
    private var pages: [OnboardingSlideViewController] = []

    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        setupSlides()
        setupPages()
        setViewControllers([pages.first!], direction: .forward, animated: true)
    }

    private func setupSlides() {
        slides = [
            OnboardingSlide(title: "Recipes from\nall over the \nWorld", imageName: "onboarding2"),
            OnboardingSlide(title: "Recipes with \neach and every \ndetail", imageName: "onboarding3"),
            OnboardingSlide(title: "Cook it now or \nsave it for later", imageName: "onboarding4")
        ]
    }

    private func setupPages() {
        pages = slides.enumerated().map { index, slide in
            let vc = OnboardingSlideViewController()
            let isLast = index == slides.count - 1
            vc.configure(with: slide, isLast: isLast, index: index, total: slides.count)
            return vc
        }
    }

    // MARK: - Page Navigation

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardingSlideViewController), index > 0 else { return nil }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardingSlideViewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
}
