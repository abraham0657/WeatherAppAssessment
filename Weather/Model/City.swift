//
//  City.swift
//  Weather
//
//  Created by Abraham Tesfamariam on 11/2/17.
//  Copyright © 2017 RJT Compuquest. All rights reserved.
//

import Foundation

struct Results: Decodable {
    var results: [City]
    
    private enum CodingKeys: String, CodingKey {
        case results = "RESULTS"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let searchResults = try container.decode([City].self, forKey: .results)
        
        results = searchResults.filter({ $0.country == "US" })
    }
}

struct City: Decodable {
    var name: String
    var country: String
    
    private enum CodingKeys: String, CodingKey {
        case country = "c"
        case name
    }
    
    func testCityObject() -> City {
        return City(name: "Chicago", country: "US")
    }
}

