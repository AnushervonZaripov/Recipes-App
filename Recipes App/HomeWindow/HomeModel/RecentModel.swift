//
//  RecentModel.swift
//  Recipes App
//
//  Created by Aziza Azizova on 14/09/25.
//

struct RecentModel: Codable {
    var results: [TrendingResult]?
}

struct RecentResult: Codable {
    var id: Int?
    var title: String?
    var image: String?
    var imageType: String?
    var author: String?
}
