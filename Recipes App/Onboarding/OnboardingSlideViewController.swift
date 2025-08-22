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

    private var presenter: OnboardingPresenterProtocol?
    private var slideIndex: Int = 0
    private var totalSlides: Int = 0

    func configure(presenter: OnboardingPresenterProtocol, index: Int, total: Int) {
        self.presenter = presenter
        self.slideIndex = index
        self.totalSlides = total
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .black

        // ImageView
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        // Overlay
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
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

        // StackView
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])

        // Spacer
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        stackView.addArrangedSubview(spacerView)

        // Title
        titleLabel.font = UIFont.poppinsBold(size: 40)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        stackView.addArrangedSubview(titleLabel)

        // PageControl
        pageControl.numberOfPages = totalSlides
        pageControl.currentPage = slideIndex
        pageControl.currentPageIndicatorTintColor = .systemPink
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.5)
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        stackView.addArrangedSubview(pageControl)

        // Continue Button
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        stackView.addArrangedSubview(continueButton)

        // Skip Button
        skipButton.backgroundColor = .clear
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        stackView.addArrangedSubview(skipButton)

        // Apply content
        if let presenter = presenter {
            let slide = presenter.getSlide(at: slideIndex)
            titleLabel.text = slide.title
            imageView.image = UIImage(named: slide.imageName)
            continueButton.setTitle(presenter.isLastSlide(index: slideIndex) ? "Start Cooking" : "Continue", for: .normal)
        }
    }

    @objc private func continueTapped() {
        guard let presenter = presenter else { return }

        if presenter.isLastSlide(index: slideIndex) {
            presenter.markOnboardingSeen()
            presentHome()
        } else {
            goToNextSlide()
        }
    }

    @objc private func skipTapped() {
        presenter?.markOnboardingSeen()
        presentHome()
    }

    private func presentHome() {
        let homeVC = RecipesTabBarController()
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true)
    }

    private func goToNextSlide() {
        guard let pageVC = self.parent as? UIPageViewController,
              let currentVC = pageVC.viewControllers?.first,
              let nextVC = pageVC.dataSource?.pageViewController(pageVC, viewControllerAfter: currentVC) else { return }
        pageVC.setViewControllers([nextVC], direction: .forward, animated: true)
    }
}
