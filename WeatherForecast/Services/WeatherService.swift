//
//  WeatherService.swift
//  WeatherForecast
//
//  Created by Maxim Kucherov on 03/12/2023.
//

import Foundation
import Alamofire

struct WeatherData: Codable {
    let name: String?
    let sys: SysData?
    let main: MainData?
    let weather: [WeatherInfoData]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case sys
        case main
        case weather
    }
}

struct SysData: Codable {
    let country: String?
    let countries: [String]?
}

struct MainData: Codable {
    let temp: Double?
    let feelsLike: Double? // Добавлен новый параметр "feels_like"
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct WeatherInfoData: Codable {
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case description
    }
}

class WeatherService {

    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func getWeather(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        
        //http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=ec4961b4f3285a88d43c0ed75cff4999

        AF.request(url).responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case .success(let weatherData):
                
                // Печать JSON-ответа
                if let data = response.data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        // Здесь продолжайте обработку данных
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
                
                completion(.success(weatherData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

