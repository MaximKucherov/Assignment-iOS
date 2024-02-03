//
//  SearchViewModel.swift
//  WeatherOnMapSearchUIKit
//
//  Created by Maxim Kucherov on 12/12/2023.
//

import Foundation

class SearchViewModel {
    private let weatherService = WeatherApiService()
    
    var searchResults: [FilterService] = []
    var citySearchResults: [CityLocationMeteoSource] = []

    func fetchLocationData(for searchTerm: String, completion: @escaping (Result<Void, Error>) -> Void) {
        weatherService.fetchByLocationName(for: searchTerm) { result in
            switch result {
            case .success(let weatherDataArray):
                
                self.searchResults.removeAll()
                
                for weatherData in weatherDataArray {
                    if let city = weatherData.name,
                       let country = weatherData.country,
                       let lat = weatherData.lat,
                       let lon = weatherData.lon,
                       let state = weatherData.state {
                        let weatherInfo = FilterService(name: city, lat: lat, lon: lon, country: country, state: state)
                        
                        if city == searchTerm {
                            self.searchResults.append(weatherInfo)
                        }
                    }
                }
                
                let filter: [FilterService] = self.searchResults
                let searchResultsSet = Set(filter)
                self.searchResults = Array(searchResultsSet)
                
                completion(.success(()))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchLocationCity(for searchTerm: String, completion: @escaping (Result<Void, Error>) -> Void) {
        weatherService.fetchLocationFindPlace(for: searchTerm) { result in
            switch result {
            case .success(let citiesData):
                self.citySearchResults.removeAll()

                for cityData in citiesData {
                    let city = CityLocationMeteoSource(
                        name: cityData.name,
                        placeId: cityData.placeId,
                        admArea1: cityData.admArea1,
                        admArea2: cityData.admArea2,
                        country: cityData.country,
                        lat: cityData.lat,
                        lon: cityData.lon,
                        timezone: cityData.timezone,
                        type: cityData.type
                    )

                    self.citySearchResults.append(city)

                }
                print("++++++++++ citySearchResults: \(self.citySearchResults)")
                completion(.success(()))
            case .failure(let error):
                print("+++fetchLocationCity: \(error)")
                completion(.failure(error))
            }
        }
    }

}
