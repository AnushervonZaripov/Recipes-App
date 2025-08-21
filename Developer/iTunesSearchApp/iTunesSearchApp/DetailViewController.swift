//
//  ViewController.swift
//  iTunesSearchApp
//
//  Created by Aziza Azizova on 04/08/25.
//

import UIKit

class DetailViewController: UIViewController {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let artistLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let genreLabel = UILabel()

    var track: Track?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configure()
    }

    private func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        artistLabel.textColor = .gray
        genreLabel.textColor = .darkGray
        releaseDateLabel.textColor = .darkGray

        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, artistLabel, genreLabel, releaseDateLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center

        imageView.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 160),
            imageView.widthAnchor.constraint(equalToConstant: 160),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    private func configure() {
        titleLabel.text = track?.trackName ?? "Нет названия"
        artistLabel.text = track?.artistName ?? "Нет артиста"
        genreLabel.text = "Жанр: \(track?.primaryGenreName ?? "не указан")"
        releaseDateLabel.text = "Дата релиза: \(formattedDate(from: track?.releaseDate))"

        if let urlString = track?.artworkUrl100, let url = URL(string: urlString) {
            // Загрузка изображения через URLSession или стороннюю библиотеку
        }
    }

    private func formattedDate(from isoDate: String?) -> String {
        guard let isoDate = isoDate else { return "неизвестно" }
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: isoDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return "неизвестно"
    }
}
