//
//  CityCountry.swift
//  WeatherOnMapSearchUIKit
//
//  Created by Maxim Kucherov on 09/12/2023.
//

import Foundation

struct CityLocation: Codable {
    let name: String?
    let lat: Double?
    let lon: Double?
    let country: String?
    let state: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case lat
        case lon
        case country
        case state
    }
}

// ------------------------------------------------------------
//  "name": "London",
//  "place_id": "london",
//  "adm_area1": "England",
//  "adm_area2": "Greater London",
//  "country": "United Kingdom",
//  "lat": "51.50853N",
//  "lon": "0.12574W",
//  "timezone": "Europe/London",
//  "type": "settlement"

struct CityLocationMeteoSource: Codable {
    let name: String?
    let placeId: String?
    let admArea1: String?
    let admArea2: String?
    let country: String?
    let lat: String?
    let lon: String?
    let timezone: String?
    let type: String?

//    init(cityData: [String:Any]) {
//        name = cityData["name"] as? String
//        placeId = cityData["place_id"] as? String
//        admArea1 = cityData["adm_area1"] as? String
//        admArea2 = cityData["adm_area2"] as? String
//        country = cityData["country"] as? String
//        lat = cityData["lat"] as? String
//        lon = cityData["lon"] as? String
//        timezone = cityData["timezone"] as? String
//        type = cityData["type"] as? String
//    }

    enum CodingKeys: String, CodingKey {
        case name
        case placeId = "place_id"
        case admArea1 = "adm_area1"
        case admArea2 = "adm_area2"
        case country
        case lat
        case lon
        case timezone
        case type
    }
}

// ------------------------------------------------------------

struct DetailLocationMeteoSource: Codable {
    let lat: String?
    let lon: String?
    let elevation: Int?
    let timezone: String?
    let units: String?
    let current: Current?
    let daily: Daily?

    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case elevation
        case timezone
        case units
        case current
        case daily
    }
}

struct Current: Codable {
    let icon: String?
    let iconNum: Int?
    let summary: String?
    let temperature: Int?
    let wind: Wind?
    let precipitation: Precipitation?
    let cloudCover: Int?

    enum CodingKeys: String, CodingKey {
        case icon
        case iconNum = "icon_num"
        case summary
        case temperature
        case wind
        case precipitation
        case cloudCover = "cloud_cover"
    }
}

struct Wind: Codable {
    let speed: Double?
    let angle: Int?
    let dir: String?

    enum CodingKeys: String, CodingKey {
        case speed
        case angle
        case dir
    }
}

struct Precipitation: Codable {
    let total: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case total
        case type
    }
}

struct Daily: Codable {
    let data: [Data]?

    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct Data: Codable {
    let day: String?
    let weather: String?
    let icon: Int?
    let summary: String?
    let allDay: AllDay?

    enum CodingKeys: String, CodingKey {
        case day
        case weather
        case icon
        case summary
        case allDay = "all_day"
    }
}

struct AllDay: Codable {
    let weather: String?
    let icon: Int?
    let temperature: Double?
    let temperatureMin: Double?
    let temperatureMax: Double?
    let wind: WindAllDay?
    let cloudCover: CloudCover?
//    let precipitation: PrecipitationAllDay?

    enum CodingKeys: String, CodingKey {
        case weather
        case icon
        case temperature
        case temperatureMin = "temperature_mix"
        case temperatureMax = "temperature_max"
        case wind
        case cloudCover = "cloud_cover"
//        case precipitation
    }
}

struct WindAllDay: Codable {
    let speed: Double?
    let angle: Int?
    let dir: String?

    enum CodingKeys: String, CodingKey {
        case speed
        case angle
        case dir
    }
}

struct CloudCover: Codable {
    let total: Int?

    enum CodingKeys: String, CodingKey {
        case total
    }
}

struct PrecipitationAllDay: Codable {
    let total: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case total
        case type
    }
}
