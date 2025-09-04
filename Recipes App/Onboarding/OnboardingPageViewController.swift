//
//  OnboardingPageViewController.swift
//  Recipes App
//
//  Created by Aziza Azizova on 20/08/25.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {

    private let presenter = OnboardingPresenter()
    private var pages: [OnboardingSlideViewController] = []
    private var currentIndex: Int = 0
    private var isTransitioning = false

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
        setupPages()
        setViewControllers([pages.first!], direction: .forward, animated: true)
    }

    private func setupPages() {
        pages = presenter.slides.enumerated().map { index, _ in
            let vc = OnboardingSlideViewController()
            vc.configure(presenter: presenter, index: index, total: presenter.slides.count)
            vc.delegate = self
            return vc
        }
    }

    func goToSlide(at index: Int) {
        guard index >= 0, index < pages.count, !isTransitioning else { return }
        let direction: UIPageViewController.NavigationDirection = index > currentIndex ? .forward : .reverse
        isTransitioning = true
        setViewControllers([pages[index]], direction: direction, animated: true) { [weak self] completed in
            guard let self = self else { return }
            if completed {
                self.currentIndex = index
                self.pages[index].updatePageControl(to: index)
            }
            self.isTransitioning = false
        }
    }
}

// MARK: - UIPageViewControllerDataSource

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingSlideViewController,
              let index = pages.firstIndex(of: currentVC),
              index > 0 else { return nil }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingSlideViewController,
              let index = pages.firstIndex(of: currentVC),
              index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
}

// MARK: - UIPageViewControllerDelegate

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed,
           let visibleVC = viewControllers?.first as? OnboardingSlideViewController,
           let index = pages.firstIndex(of: visibleVC) {
            currentIndex = index
            visibleVC.updatePageControl(to: index)
        }
    }
}

// MARK: - Slide-to-Page Communication

extension OnboardingPageViewController: OnboardingSlideDelegate {
    func didTapContinue(from index: Int) {
        if presenter.isLastSlide(index: index) {
            presenter.markOnboardingSeen()
            let homeVC = RecipesTabBarController()
            homeVC.modalPresentationStyle = .fullScreen
            present(homeVC, animated: true)
        } else {
            goToSlide(at: index + 1)
        }
    }

    func didTapSkip() {
        presenter.markOnboardingSeen()
        let homeVC = RecipesTabBarController()
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true)
    }
}
