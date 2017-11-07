//
//  WeatherData.swift
//  Weather
//
//  Created by Abraham Tesfamariam on 11/2/17.
//  Copyright © 2017 RJT Compuquest. All rights reserved.
//

import Foundation

struct WeatherReport: Decodable {
    let kelvinConvert = 273.15
    var temp: Double
    var minTemp: Double
    var maxTemp: Double
    var windSpeed: Double
    var cityName: String
    var weatherForecast: [WeatherDescription]

    private enum CodingKeys: String, CodingKey {
        case main
        case weatherForecast = "weather"
        case wind
        case cityName = "name"
        
        enum TemperatureData: String, CodingKey {
            case temp
            case minTemp = "temp_min"
            case maxTemp = "temp_max"
        }
        
        enum WindData: String, CodingKey {
            case windSpeed = "speed"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let temperatureDataContainer = try container.nestedContainer(keyedBy: CodingKeys.TemperatureData.self, forKey: .main)
        let windDataContainer = try container.nestedContainer(keyedBy: CodingKeys.WindData.self, forKey: .wind)

        // subtracted to get Farenheit amount
        temp = try temperatureDataContainer.decode(Double.self, forKey: .temp) - kelvinConvert
        minTemp = try temperatureDataContainer.decode(Double.self, forKey: .minTemp) - kelvinConvert
        maxTemp = try temperatureDataContainer.decode(Double.self, forKey: .maxTemp) - kelvinConvert
        
        cityName = try container.decode(String.self, forKey: .cityName)
        weatherForecast = try container.decode([WeatherDescription].self, forKey: .weatherForecast)
        windSpeed = try windDataContainer.decode(Double.self, forKey: .windSpeed)
    }
}

struct WeatherDescription: Decodable {
    var id: Int
    var main: String
    var desc: String
    var icon: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case main
        case desc = "description"
        case icon
    }
}
