//
//  Models.swift
//  Weather App
//
//  Created by cloud_vfx on 06/09/22.
//

import UIKit

struct WeatherFull: Decodable {
    
    var lat : Double
    var lon : Double
    var timezone: String
    var timezone_offset : Double
    
    var current: Current
    var hourly : [Hourly]
    var daily : [Daily]
}

struct Current: Decodable {
    
    let dt: Double?
    let temp: Double?
    var feels_like: Double?
    var pressure: Int?
    var humidity: Int?
    var wind_speed: Double?
    let weather : [Weather]
}

struct Weather : Decodable{
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Hourly: Decodable {
    var dt: Double
    var temp: Double
    var wind_speed: Double
    var weather: [Weather]
}

struct Daily: Decodable {

    var dt: Double
    var sunrise: Double
    var sunset: Double
    var moonrise: Double
    var moonset: Double
    var pressure: Int
    var humidity: Int
    var wind_speed: Double?
    var clouds: Int?
    var temp: Temp?
    var feels_like: Feels_like?
    var weather = [Weather]()
}

struct Temp: Decodable {
    var day : Double
    var night: Double?
    var eve: Double?
    var morn: Double
}

struct Feels_like : Decodable {
    var day: Double?
    var night: Double?
    var eve: Double?
    var morn: Double?
}


class City {
    var id: Int?
    var name: String?
    var state: String?
    var country: String?
}

class Definition {
    var defText: String?
    var iconName: String?
    init(defText:String = "", iconName:String = "") {
        self.defText = defText
        self.iconName = iconName
    }
}
