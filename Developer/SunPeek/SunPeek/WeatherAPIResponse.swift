//
//  WeatherAPIResponse.swift
//  SunPeek
//
//  Created by Aziza Azizova on 03/08/25.
//

struct WeatherAPIResponse: Codable {
    let forecast: Forecast
    let location: Location
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: String
    let day: Day
}

struct Day: Codable {
    let avgtempC: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case avgtempC = "avgtemp_c"
        case condition
    }
}

struct Condition: Codable {
    let text: String
    let icon: String
}

struct Location: Codable {
    let name: String
    let country: String
    let localtime: String
}

