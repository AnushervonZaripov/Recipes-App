/*
 Задание 1
*/

import UIKit

 class ProfileViewController: UIViewController {

    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let saveButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        loadUserData()
    }

    private func setupView() {
        view.backgroundColor = .white

        [profileImageView, nameLabel, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),

            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            saveButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
   
     func loadUserData() {
         /* 1. использования try! - плохо если интернет не работает, или сервер вернул ошибку, то приложение упадет
          2. скачивание данных на главном потоке Data(contentsOf:) работает синхронно, то есть блокирует главный поток. Интерфейс зависнет, пока идёт загрузка
          3. as! — Если данные не в нужном формате, приложение упадёт
          4. URL(string:)! — тоже может вызвать падение, если строка неправильная
          p.s. изучить эту часть кода мне помог AI
          */
         let url = URL(string: "https://api.example.com/user")!
         let data = try! Data(contentsOf: url)
         let json = try! JSONSerialization.jsonObject(with: data) as! [String: Any]
         nameLabel.text = json["name"] as? String
         if let imageURLString = json["image"] as? String, let imageURL = URL(string: imageURLString) {
             let imageData = try! Data(contentsOf: imageURL)
             profileImageView.image = UIImage(data: imageData)
         }
     }
     
     @objc func saveButtonTapped() {
            print("Кнопка сохранения нажата")
        }
    }


/*
 Задание 2
*/
protocol Drivable {
    func drive(distance: Double)
}

protocol EngineStartable {
    func startEngine()
}

class Car: Drivable, EngineStartable {
    func startEngine() {
        print("Car engine started")
    }

    func drive(distance: Double) {
        print("Driving \(distance) km")
    }
}

class Bicycle: Drivable {
    func drive(distance: Double) {
        print("Pedaling \(distance) km")
    }
}



/*Задание 3
 */
class BaseButton: UIButton {
    func configure(title: String, backgroundColor: UIColor = .systemBlue) {
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        setTitleColor(.white, for: .normal)
    }

    func performAction() {
        print("Base action executed")
    }
}

class LoadingButton: BaseButton {
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    override func configure(title: String, backgroundColor: UIColor = .systemGray) {
        super.configure(title: title, backgroundColor: backgroundColor)
        setupActivityIndicator()
    }

    override func performAction() {
        activityIndicator.startAnimating()
        print("Loading... no real action performed")
    }

    private func setupActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}


    /*Доп. задание*/
    // До:
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

    // После:
import UIKit

class WeatherViewController: UIViewController {

    private let tableView = UITableView()
    private var forecastDays: [ForecastDay] = []
    private var cityName: String = ""

    private let dateFormatter = DateFormatter()

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
        tableView.rowHeight = 60
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

            self.forecastDays = data.forecast.forecastday
            self.cityName = data.location.name
            self.title = "SunPeek — \(self.cityName)"
            self.tableView.reloadData()
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

        let dayString = formattedDay(from: weather.date)
        let temp = "\(Int(weather.day.avgtempC))°C"
        let description = weather.day.condition.text
        let iconName = systemIcon(for: weather.day.condition.code)
        let icon = UIImage(systemName: iconName)

        cell.textLabel?.text = "\(dayString): \(temp) — \(description)"
        cell.imageView?.image = icon
        cell.imageView?.tintColor = .label

        return cell
    }

    private func formattedDay(from dateString: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return dateString }
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }

    private func systemIcon(for code: Int) -> String {
        switch code {
        case 1000: return "sun.max"
        case 1003: return "cloud.sun"
        case 1006, 1009: return "cloud"
        case 1030, 1135, 1147: return "cloud.fog"
        case 1063, 1180...1201: return "cloud.rain"
        case 1273...1282: return "cloud.bolt"
        case 1066, 1069, 1072, 1114, 1117, 1210...1237: return "snow"
        default: return "cloud"
        }
    }
}

