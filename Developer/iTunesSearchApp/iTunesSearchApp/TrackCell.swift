//
//  TrackCell.swift
//  iTunesSearchApp
//
//  Created by Aziza Azizova on 04/08/25.
//

import UIKit

class TrackCell: UITableViewCell {
    static let reuseId = "TrackCell"

    private let trackImageView = UIImageView()
    private let nameLabel = UILabel()
    private let artistLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with track: Track) {
        nameLabel.text = track.trackName
        artistLabel.text = track.artistName
        if let urlString = track.artworkUrl100, let url = URL(string: urlString) {
            // Можно добавить URLSession или использовать SDWebImage
        }
    }

    private func setupViews() {
        trackImageView.contentMode = .scaleAspectFill
        trackImageView.clipsToBounds = true
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        artistLabel.textColor = .gray
        artistLabel.font = UIFont.systemFont(ofSize: 14)

        contentView.addSubview(trackImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(artistLabel)
    }

    private func setupConstraints() {
        trackImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            trackImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            trackImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            trackImageView.widthAnchor.constraint(equalToConstant: 60),
            trackImageView.heightAnchor.constraint(equalToConstant: 60),

            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            artistLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
        ])
    }
}
