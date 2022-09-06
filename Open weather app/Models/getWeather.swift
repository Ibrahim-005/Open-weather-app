//
//  getWeather.swift
//  Weather App
//
//  Created by cloud_vfx on 05/09/22.
//

import Foundation
import CoreLocation

let weatherManager = WeatherManager()

func getWeather(city: String, completion: @escaping(WeatherFull, _ name: String?)->Void){
    
    getCoordinate(city: city){ coordinate , name , error in
    
        weatherManager.fetchWeather(lat: coordinate.coordinate.latitude , long: coordinate.coordinate.longitude ) { weather in
            completion(weather, name)
        }
    }
}

func getCoordinate(city: String , completion: @escaping(_ conrdinat : CLLocation, _ nameCity: String? , _ error: Error?) -> Void) {
    CLGeocoder().geocodeAddressString(city) { placemark, error in
        completion((placemark?.first?.location) ?? CLLocation(), placemark?.first?.locality, error)
    }
}

