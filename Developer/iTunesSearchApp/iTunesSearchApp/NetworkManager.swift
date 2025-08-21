//
//  NetworkManager.swift
//  iTunesSearchApp
//
//  Created by Aziza Azizova on 04/08/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    func fetchTracks(for term: String, completion: @escaping ([Track]) -> Void) {
        let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://itunes.apple.com/search?term=\(encodedTerm)&entity=song"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(SearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.results)
                }
            } catch {
                print("Ошибка декодирования: \(error)")
            }
        }.resume()
    }
}

