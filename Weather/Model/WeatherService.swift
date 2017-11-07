//
//  WeatherService.swift
//  Weather
//
//  Created by Abraham Tesfamariam on 11/2/17.
//  Copyright © 2017 RJT Compuquest. All rights reserved.
//

import Foundation

enum ConfigConstants: String {
    case weatherURL = "http://api.openweathermap.org/data/2.5/weather?q="
    case weatherURLAPIKey = "&APPID=789d25f2b8cfa2c3f5a045e1dec5a2a1"
    case cityURL = "http://autocomplete.wunderground.com/aq?query="
    case iconAPI = "http://openweathermap.org/img/w/"
}


class WeatherService {
    static let shared = WeatherService()
    
    /*
     @description: Fetches weather data for the detail screen
     @param: Void
     @return: Void
     */
    func fetchData(cityName: String, completion: @escaping (WeatherReport?, Error?)->Void) {
        let defaults = UserDefaults.standard
        let nameForURL = cityName.replacingOccurrences(of: " ", with: "%20")
        defaults.set(nameForURL, forKey: "previousSearch")
        
        guard let url = URL(string: ConfigConstants.weatherURL.rawValue + nameForURL + ConfigConstants.weatherURLAPIKey.rawValue) else { return }
        
        self.makeServiceCall(url: url) { (data, error) in
            if error == nil {
                do {
                    if let data = data {
                        let weatherData = try JSONDecoder().decode(WeatherReport.self, from: data)
                        completion(weatherData, nil)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    
    /*
     @description: Fetches availables cities during the user search.
     @param: Void
     @return: Void
     */
    func fetchCity(query: String, completion: @escaping ([City]?, Error?)->Void) {
        guard let url = URL(string: ConfigConstants.cityURL.rawValue + query) else { return }
        
        self.makeServiceCall(url: url) { (data, error) in
            if error == nil {
                do {
                    if let data = data {
                        let cityData = try JSONDecoder().decode(Results.self, from: data)
                        completion(cityData.results, nil)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    /*
     @description: URLSession wrapper
     @param: Void
     @return: Void
     */
    func makeServiceCall(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                completion(data, nil)
            } else {
                completion(nil, error)
            }
        }.resume()
    }
}
