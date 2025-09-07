//
//  PopularModel.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 06/09/25.
//
struct PopularModel: Codable {
    let results: [PopularResult]
}

struct PopularResult: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let maxReadyTime: Int?
}
