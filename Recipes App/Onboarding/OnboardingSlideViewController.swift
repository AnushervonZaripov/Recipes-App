//
//  OnboardingSlideViewController.swift
//  Recipes App
//
//  Created by Aziza Azizova on 20/08/25.
//

import UIKit

class OnboardingSlideViewController: UIViewController {

    private let imageView = UIImageView()
    private let overlayView = UIView()
    private let titleLabel = UILabel()
    private let continueButton = UIButton.makeButton(
        text: "Continue",
        font: .poppinsBold(size: 20),
        size: CGSize(width: UIScreen.main.bounds.width - 42, height: 44),
        cornerRadius: 22
    )
    private let skipButton = UIButton.makeButton(
        text: "Skip",
        font: .poppinsRegular(size: 14),
        size: CGSize(width: 60, height: 20)
    )

    private let pageControl = UIPageControl()
    private let stackView = UIStackView()

    private var slide: OnboardingSlide?
    private var isLastSlide = false
    private var currentIndex = 0
    private var totalSlides = 0

    func configure(with slide: OnboardingSlide, isLast: Bool = false, index: Int, total: Int) {
        self.slide = slide
        self.isLastSlide = isLast
        self.currentIndex = index
        self.totalSlides = total
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        continueButton.setTitle(isLastSlide ? "Start Cooking" : "Continue", for: .normal)
    }

    private func setupUI() {
        view.backgroundColor = .black

        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        overlayView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        view.addSubview(overlayView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])

        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        stackView.addArrangedSubview(spacerView)

        titleLabel.font = UIFont.poppinsBold(size: 40)
        titleLabel.textColor = .white0
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        stackView.addArrangedSubview(titleLabel)

        pageControl.numberOfPages = totalSlides
        pageControl.currentPage = currentIndex
        pageControl.currentPageIndicatorTintColor = UIColor.systemPink
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.5)
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(pageControl)
        pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true

        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        stackView.addArrangedSubview(continueButton)

        skipButton.backgroundColor = .clear
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        stackView.addArrangedSubview(skipButton)

        if let slide = slide {
            titleLabel.text = slide.title
            imageView.image = UIImage(named: slide.imageName)
        }
    }

    @objc private func continueTapped() {
        if isLastSlide {
            UserDefaults.standard.hasSeenOnboarding = true
            let homeVC = RecipesTabBarController()
            homeVC.modalPresentationStyle = .fullScreen
            present(homeVC, animated: true)
        } else {
            if let pageVC = self.parent as? UIPageViewController,
               let currentVC = pageVC.viewControllers?.first,
               let nextVC = pageVC.dataSource?.pageViewController(pageVC, viewControllerAfter: currentVC) {
                pageVC.setViewControllers([nextVC], direction: .forward, animated: true)
            }
        }
    }

    @objc private func skipTapped() {
        UserDefaults.standard.hasSeenOnboarding = true
        let homeVC = RecipesTabBarController()
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true)
    }
}
