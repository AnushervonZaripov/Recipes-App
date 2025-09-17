//
//  TrendingModel.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 06/09/25.
//

struct TrendingModel: Codable {
    var results: [TrendingResult]?
}

struct TrendingResult: Codable {
    var id: Int?
    var title: String?
    var image: String?
    var imageType: String?
    var author: String?
    var maxReadyTime: Int?
    
}
