//
//  Model.swift
//  WeatherForecast
//
//  Created by MacBook Pro on 12/7/20.
//  Copyright © 2020 MailMedia. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Root: Codable , Identifiable {
    var id = UUID()
    let list: [Content]
    
    enum CodingKeys: String, CodingKey {
        case list 
    }
}
 

// MARK: - Coord
struct Coord: Codable , Identifiable {
    var id = UUID()
    let lat, lon: Double
    enum CodingKeys: String, CodingKey {
        case lat,lon
    }
}

// MARK: - List
struct Content: Codable , Identifiable {
    var id = UUID()
    let dt: Double
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop
        case dtTxt = "dt_txt" 
    }
}

// MARK: - Clouds
struct Clouds: Codable , Identifiable {
    var id = UUID()
    let all: Int
    enum CodingKeys: String, CodingKey {
        case all
    }
}

// MARK: - MainClass
struct MainClass: Codable , Identifiable {
    var id = UUID()
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}
 

// MARK: - Weather
struct Weather: Codable , Identifiable {
    var id = UUID()
    let icon: String

    enum CodingKeys: String, CodingKey {
        case icon
    }
}
 
 
// MARK: - Wind
struct Wind: Codable , Identifiable {
    var id = UUID()
    let speed: Double
    let deg: Int
    
    enum CodingKeys: String, CodingKey {
        case speed, deg
    }
}

struct Main:Identifiable {
      
    var id = UUID()
    let index:Int
    let list:[Content]
}

 
