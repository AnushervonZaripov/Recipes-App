//
//  OnboardingPageViewController.swift
//  Recipes App
//
//  Created by Aziza Azizova on 20/08/25.
//

import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    private let presenter = OnboardingPresenter()
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
        setupPages()
        setViewControllers([pages.first!], direction: .forward, animated: true)
    }

    private func setupPages() {
        pages = presenter.slides.enumerated().map { index, _ in
            let vc = OnboardingSlideViewController()
            vc.configure(presenter: presenter, index: index, total: presenter.slides.count)
            return vc
            
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardingSlideViewController), index > 0 else { return nil }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardingSlideViewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
}
