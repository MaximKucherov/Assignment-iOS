//
//  WeatherService.swift
//  WeatherOnMapSearchUIKit
//
//  Created by Maxim Kucherov on 03/12/2023.
//

import Foundation
import Alamofire

class WeatherApiService {
    private let apiKey: String
    
    init(apiKey: String = "aa7d26659baf1b3c520d5c07af95f49d") {
        self.apiKey = apiKey
    }

    // city -> Name, Latitude, Longitude, Country, State
    func fetchByLocationName(for city: String, completion: @escaping (Result<[CityLocation], Error>) -> Void) {
        let url = "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=5&appid=\(apiKey)"
        
      AF.request(url)
        .validate()
        .responseDecodable(of: [CityLocation].self) { response in
          switch response.result {
          case .success(let cityCountry):
            completion(.success(cityCountry))
          case .failure(let error):
            completion(.failure(error))
          }
        }
    }

  func fetchLocationFindPlace(for city: String, completion: @escaping (Result<[CityLocationMeteoSource], Error>) -> Void) {

      let apiKey = "wujykhcp5z7sktx72wz467a31ipcppo7rxpf9cud"
      let url = "https://www.meteosource.com/api/v1/free/find_places?text=\(city)&key=\(apiKey)"

      AF.request(url)
          .validate()
          .responseDecodable(of: [CityLocationMeteoSource].self) { response in
              switch response.result {
              case .success(let cityCountry):
                  completion(.success(cityCountry))
              case .failure(let error):
                  completion(.failure(error))
              }
          }
  }

  func fetchDetailLocationWeather(for city: String, completion: @escaping (Result<DetailLocationMeteoSource, Error>) -> Void) {

    let apiKey = "wujykhcp5z7sktx72wz467a31ipcppo7rxpf9cud"
        let url = "https://www.meteosource.com/api/v1/free/point?place_id=\(city)&sections=all&timezone=UTC&language=en&units=metric&key=\(apiKey)"

      AF.request(url)
        .validate()
        .responseDecodable(of: DetailLocationMeteoSource.self) { response in
          switch response.result {
          case .success(let cityCountry):
            print("Success MeteoSource: \(cityCountry)")
          case .failure(let error):
            print("Error MeteoSource: \(error)")
         }
      }
  }


    func fetchDetailsData(lat: Double, lon: Double, completion: @escaping (Result<WeatherDetails, Error>) -> Void) {
        let lang = NSLocalizedString("lang", comment: "")
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&\(lang)"
        
        AF.request(url)
        .validate()
        .responseDecodable(of: WeatherDetails.self) { response in
            switch response.result {
            case .success(let weatherDetails):
                completion(.success(weatherDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchLocationApi(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherDetails, Error>) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        
        AF.request(url)
        .validate()
        .responseDecodable(of: WeatherDetails.self) { response in
            switch response.result {
            case .success(let locationData):
                completion(.success(locationData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

  

}


