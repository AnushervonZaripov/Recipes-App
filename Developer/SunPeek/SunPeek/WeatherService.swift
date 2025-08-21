//
//  WeatherService.swift
//  SunPeek
//
//  Created by Aziza Azizova on 02/08/25.
//

import Foundation

class WeatherService {
    func fetchWeather(completion: @escaping (WeatherAPIResponse?) -> Void) {
    
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=aac48dab0d734d40a09194502250208&q=Dushanbe&days=7&aqi=no&alerts=no"

        guard let url = URL(string: urlString) else {
            print("❌ Неверный URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                print("📦 JSON: \(String(data: data, encoding: .utf8) ?? "—")")
                do {
                    let decoded = try JSONDecoder().decode(WeatherAPIResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(decoded)
                    }
                } catch {
                    print("❌ Ошибка декодирования: \(error.localizedDescription)")
                    completion(nil)
                }
            } else {
                print("❌ Нет данных: \(error?.localizedDescription ?? "—")")
                completion(nil)
            }
        }.resume()
    }
}
