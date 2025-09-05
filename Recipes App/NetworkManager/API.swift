//
//  API.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 03/09/25.
//

// https://spoonacular.com/food-api

import Foundation

//описание конкретного сервиса

struct API {
    static let scheme = "https"
    static let host = "api.spoonacular.com"
    static let apiKey = Token.first
}

struct Token {
    static let first = "87a56163497347eaa065c8785d4024d8"
}


// другой сервис
