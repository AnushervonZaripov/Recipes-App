//
//  SearchViewController.swift
//  iTunesSearchApp
//
//  Created by Aziza Azizova on 04/08/25.
//

import UIKit

class SearchViewController: UIViewController {

    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var tracks: [Track] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iTunes Search"
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        searchBar.delegate = self
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)

        tableView.dataSource = self
        tableView.delegate = self // 🆕 подключаем делегат!
        tableView.register(TrackCell.self, forCellReuseIdentifier: TrackCell.reuseId)

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func fetchTracks(term: String) {
        activityIndicator.startAnimating()
        NetworkManager.shared.fetchTracks(for: term) { [weak self] result in
            self?.tracks = result
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text, !text.isEmpty {
            fetchTracks(term: text)
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.reuseId, for: indexPath) as? TrackCell else {
            return UITableViewCell()
        }
        let track = tracks[indexPath.row]
        cell.configure(with: track)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedTrack = tracks[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.track = selectedTrack
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
