//
//  Track.swift
//  iTunesSearchApp
//
//  Created by Aziza Azizova on 04/08/25.
//

import Foundation

struct SearchResponse: Codable {
    let results: [Track]
}

struct Track: Codable {
    let trackName: String?
    let artistName: String?
    let artworkUrl100: String?
    let releaseDate: String?
    let primaryGenreName: String?
}
