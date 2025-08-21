//
//  WeatherViewController.swift
//  SunPeek
//
//  Created by Aziza Azizova on 02/08/25.
//

import UIKit

class WeatherViewController: UIViewController {

    private let tableView = UITableView()
    private var forecastDays: [ForecastDay] = []
    private var cityName: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SunPeek"
        view.backgroundColor = .systemBackground
        setupTableView()
        fetchData()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.rowHeight = 60  // ✅ Установили высоту строки
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WeatherCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func fetchData() {
        WeatherService().fetchWeather { [weak self] data in
            guard let self = self, let data = data else {
                print("❌ Нет данных с WeatherAPI")
                return
            }

            print("✅ Загружено дней: \(data.forecast.forecastday.count)")
            self.forecastDays = data.forecast.forecastday
            print("🤖 forecastDays.count: \(self.forecastDays.count)")
            self.tableView.reloadData()
            self.cityName = data.location.name
            self.title = "SunPeek — \(self.cityName)"

        }
    }
}

extension WeatherViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastDays.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        let weather = forecastDays[indexPath.row]

        let dateString = weather.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "EEEE"
            let dayString = formatter.string(from: date)

            let temp = "\(Int(weather.day.avgtempC))°C"
            let description = weather.day.condition.text
            let system = UIImage(systemName: "cloud.sun.fill")  // Временно фиксированная иконка

            cell.textLabel?.text = "\(dayString): \(temp) — \(description)"
            cell.imageView?.image = system
            cell.imageView?.tintColor = .label
        }

        return cell
    }

    private func systemIcon(for code: String) -> String {
        switch code {
        case "01d": return "sun.max"
        case "01n": return "moon"
        case "02d": return "cloud.sun"
        case "02n": return "cloud.moon"
        case "03d", "03n", "04d", "04n": return "cloud"
        case "09d", "10d", "09n", "10n": return "cloud.rain"
        case "11d", "11n": return "cloud.bolt"
        case "13d", "13n": return "snow"
        case "50d", "50n": return "cloud.fog"
        default: return "cloud"
        }
    }
}
