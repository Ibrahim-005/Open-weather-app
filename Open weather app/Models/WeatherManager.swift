//
//  WeatherManager.swift
//  Weather App
//
//  Created by cloud_vfx on 05/09/22.
//

import Foundation

struct WeatherManager {
    
    func fetchWeather(lat: Double, long: Double , completion: @escaping(WeatherFull) -> Void){
        
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=minutely&appid=7650f54e069eed55a74adb5a27e5e2ea&units=metric"
        
        guard let url = URL(string: urlString) else {return}
      
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else{
                return
            }
            if let weatherData = self.parseJson(data){
                completion(weatherData)
            }
        }
        task.resume()
    }
    
    func parseJson(_ data: Data) -> WeatherFull? {
        
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherFull.self, from: data)
          
           return decodedData
        }
        catch _ as NSError {
            print("DECODINGGGG__ERRROOOORRR")
        }
        return nil
    }
}
