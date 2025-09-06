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
    static let apiKey = Token.firstKey
}

struct Token {
    
    static let firstKey = "dbe02e6c827948cab1164a95cab41203"
    static let secondKey = "97534030321f4b98b1a71a171f2a5d77"
    static let third = "5ae93d38d7cf4f94912465f822fa82eb"
    static let fourth = "8af6d4be783d4b43b39b0462d2922c25"
    static let fifth = "83f1f194da3247dea340def455587b9e"
    static let six = "14bce0d6c60c40159cef29d9763aac19"
    static let seven = "a1a20a4a124747d68fb8dd4f0a957e45"
    static let eight = "0550a12354c74c4b92da388c778540d7"
    static let nine = "f181665459eb48d9b46f7ed64fdcc92e"
    static let ten = "7bacf3f7cc7e408e9949dd374a8ddad7"
    static let eleven = "8cf18949852e4f6e82c12342cf83cdc9"
    static let twelve = "11e930669851467ebda17458e91269a9"
    static let thirteen = "977e7847d283492bb87bffe3d7256e12"
    static let fourteen = "3df4748a170f45ce9c519d7371a16480"
    static let fifteen = "4746f1a7e1ad4876996cd8e626b05ce4"
    static let sixteen = "b6dbf7fcf5094745ac11204866483713"
    static let seventeen = "f53c3c540feb41b08450248060e8cd77"
}


// другой сервис
