//
//  WeatherData.swift
//  SunPeek
//
//  Created by Aziza Azizova on 02/08/25.
//

import Foundation

struct WeatherData: Codable {
    let current: CurrentWeather
    let daily: [DailyWeather]
}

struct CurrentWeather: Codable {
    let temp: Double
    let weather: [WeatherDescription]
}

struct DailyWeather: Codable {
    let dt: TimeInterval
    let temp: Temperature
    let weather: [WeatherDescription]
}

struct Temperature: Codable {
    let day: Double
}

struct WeatherDescription: Codable {
    let main: String
    let icon: String
}

