//
//  SearchViewController.swift
//  WeatherForecast
//
//  Created by Maxim Kucherov on 23/11/2023.
//

import UIKit
import MapKit

struct WeatherInfo {
    let cityName: String?
    let country: String?
    let temperature: Double?
    let weatherDescription: String?
    let feelsLike: Double?
    
    init(cityName: String?, country: String?, temperature: Double?, weatherDescription: String?, feelsLike: Double?) {
        self.cityName = cityName
        self.country = country
        self.temperature = temperature
        self.weatherDescription = weatherDescription
        self.feelsLike = feelsLike
    }
}

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchResults: [WeatherInfo] = [] // Сюда будут сохранены результаты поиска
    private let weatherService = WeatherService(apiKey: "Put_Your_API_KEY")
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureSearchController()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self

        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white
        searchController.searchBar.searchTextField.leftView?.tintColor = .purple
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([.foregroundColor: UIColor.purple], for: .normal)
        searchController.searchBar.delegate = self
        
        searchController.isActive = true
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        let weatherInfo = searchResults[indexPath.row]
        cell.textLabel?.text = "\(weatherInfo.cityName ?? ""), \(weatherInfo.country ?? "")"
        
        // Добавляем кастомное изображение с белой стрелкой
        let disclosureImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        disclosureImageView.tintColor = .white
        cell.accessoryView = disclosureImageView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWeatherInfo = searchResults[indexPath.row]
        
        let weatherDetailVC = WeatherDetailViewController()
        weatherDetailVC.weatherInfo = selectedWeatherInfo
        
        // Установите hidesBottomBarWhenPushed в true перед выполнением навигации
        weatherDetailVC.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(weatherDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchTerm = searchController.searchBar.text else { return }

        weatherService.getWeather(for: searchTerm) { result in
            switch result {
            case .success(let weatherData):
                // Обработайте данные о погоде
                if let cityName = weatherData.name,
                   let country = weatherData.sys?.country,
                   let temperature = weatherData.main?.temp,
                   let feelsLike = weatherData.main?.feelsLike,
                   let weatherDescr = weatherData.weather?.first?.description {
                    print(weatherDescr)
                    let weatherInfo = WeatherInfo(cityName: cityName,
                                                  country: country,
                                                  temperature: temperature,
                                                  weatherDescription: weatherDescr,
                                                  feelsLike: feelsLike
                    )

                    // Очищаем массив результатов поиска
                    self.searchResults.removeAll()

                    // Добавляем новый результат в массив
                    self.searchResults.append(weatherInfo)

                    // Обновите отображение таблицы
                    self.tableView.reloadData()
                }

            case .failure(let error):
                print("Error fetching weather data: \(error)")
            }
        }
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Вызывается при нажатии на кнопку "Search" на клавиатуре
        // Вы можете добавить дополнительную логику здесь, если необходимо
        searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Скрыть клавиатуру при нажатии на "Cancel"
        searchBar.resignFirstResponder()
    }
    
}
