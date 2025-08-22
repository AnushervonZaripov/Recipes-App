//
//  WelcomeViewController.swift
//  Recipes App
//
//  Created by Aziza Azizova on 20/08/25.
//

import UIKit

class WelcomeViewController: UIViewController {

    private let presenter = WelcomePresenter()
    private let backgroundImageView = UIImageView()
    private let gradientView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let getStartedButton = UIButton.makeButton(
        text: "Get started",
           font: .poppinsRegular(size: 18),
           size: CGSize(width: 240, height: 52),
           cornerRadius: 12
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animateAppearance()
    }

    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           applyGradient()
       }

    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            if !presenter.shouldShowOnboarding {
                let homeVC = HomeViewController()
                homeVC.modalPresentationStyle = .fullScreen
                present(homeVC, animated: false)
            }
        }

    private func setupUI() {
        view.backgroundColor = .white

        backgroundImageView.image = UIImage(named: "onboarding1")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)

        gradientView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gradientView)

        titleLabel.text = "Best\nRecipe"
        titleLabel.font = .poppinsBold(size: 60)
        titleLabel.textColor = .white0
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        subtitleLabel.text = "Find best recipes for cooking"
        subtitleLabel.font = .poppinsRegular(size: 16)
        subtitleLabel.textColor = .white0
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.addTarget(self, action: #selector(startOnboarding), for: .touchUpInside)

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(getStartedButton)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9),

            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),

            subtitleLabel.bottomAnchor.constraint(equalTo: getStartedButton.topAnchor, constant: -24),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.95).cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)

        gradientView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        gradientView.layer.addSublayer(gradientLayer)
    }

    private func animateAppearance() {
        titleLabel.alpha = 0
        subtitleLabel.alpha = 0
        getStartedButton.alpha = 0

        UIView.animate(withDuration: 1.0, delay: 0.3, options: [.curveEaseInOut], animations: {
            self.titleLabel.alpha = 1
            self.subtitleLabel.alpha = 1
            self.getStartedButton.alpha = 1
        }, completion: nil)
    }

    @objc private func startOnboarding() {
           let onboardingVC = OnboardingPageViewController()
           onboardingVC.modalPresentationStyle = .fullScreen
           present(onboardingVC, animated: true)
       }
}
