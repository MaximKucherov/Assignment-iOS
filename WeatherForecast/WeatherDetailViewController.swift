//
//  WeatherDetailViewController.swift
//  WeatherForecast
//
//  Created by Maxim Kucherov on 03/12/2023.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    var weatherInfo: WeatherInfo?
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 64, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let discriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(WeatherDetailTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let addToFavoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to favorite", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateCityStackView = UIStackView(arrangedSubviews: [dateLabel, cityNameLabel])
        dateCityStackView.axis = .vertical
        
        let tempDiscFeelStackView = UIStackView(arrangedSubviews: [temperatureLabel, discriptionLabel, feelsLikeLabel])
        tempDiscFeelStackView.axis = .vertical
        
        // Установите largeTitleDisplayMode в .never
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        
        view.addSubview(dateCityStackView)
        
        dateCityStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateCityStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateCityStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dateCityStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        view.addSubview(tempDiscFeelStackView)
        tempDiscFeelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempDiscFeelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tempDiscFeelStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tempDiscFeelStackView.topAnchor.constraint(equalTo: dateCityStackView.bottomAnchor, constant: 50)
        ])
        
        // Обновите информацию о погоде при загрузке экрана
        updateWeatherInfo()
        
        // Настройте изображение в NavigationController для возврата на предыдущий экран
        configureBackButton()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Установите constraint'ы для tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tempDiscFeelStackView.bottomAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 44 * 5)
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Устанавливаем свойство hidesBottomBarWhenPushed обратно в false, чтобы сбросить его для будущих контроллеров
        hidesBottomBarWhenPushed = false
        
        view.addSubview(addToFavoriteButton)
        addToFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            addToFavoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            addToFavoriteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
            
            addToFavoriteButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            addToFavoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            addToFavoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            addToFavoriteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
}
    
    private func updateWeatherInfo() {
        guard let cityName = weatherInfo?.cityName,
//              let country = weatherInfo?.country,
              let temperature = weatherInfo?.temperature,
              let feelsLike = weatherInfo?.feelsLike,
              let weatherDescription = weatherInfo?.weatherDescription else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
//        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMM yyyy")
        
        let todayDate = dateFormatter.string(from: Date())
        let temperaturaText = "\(Int(temperature - 273.15))°C"
        let feelsLikeText = "\(Int(feelsLike - 273.15))°C"
        let firstCharacter = weatherDescription.prefix(1).uppercased()
        let restOfTheString = weatherDescription.dropFirst()
        let weatherDescrText = firstCharacter + restOfTheString
        
        temperatureLabel.text = temperaturaText
        discriptionLabel.text = weatherDescrText
        feelsLikeLabel.text = "Feel like \(feelsLikeText)"
        
        dateLabel.text = todayDate
        cityNameLabel.text = cityName
    }
    
    private func configureBackButton() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        backButton.tintColor = .purple
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension WeatherDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherDetailTableViewCell
        
        cell.weekDayLabel.text = "Monday"
        cell.iconPercentLabel.text = "icon&%"
        cell.tempLabel.text = "20°C"
        
        cell.backgroundColor = .clear
        cell.weekDayLabel.textColor = .white
        cell.iconPercentLabel.textColor = .white
        cell.tempLabel.textColor = .white
        
        let weatherInfo = indexPath.row + 1
        cell.textLabel?.text = "\(weatherInfo)"
        
        return cell
    }
    
}
