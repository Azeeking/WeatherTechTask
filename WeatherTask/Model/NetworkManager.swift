//
//  NetworkManager.swift
//  WeatherTask
//
//  Created by Azik on 19.12.2022.
//

import Foundation
import Alamofire

protocol NetworkManagerDelegate {
    func updateWeather(with model : WeatherModel)
}

struct NetworkManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=3c6739d1e1a6c8efdd4436b4d879174d&units=metric"
    
    var delegate: NetworkManagerDelegate?
    
    func getWeather(by cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        AF.request(urlString).responseDecodable { (response: DataResponse<WeatherData, AFError>) in
            switch response.result {
            case .success(let weatherData):
                let id = weatherData.weather[0].id
                let name = weatherData.name
                let temp = weatherData.main.temp
                let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
                delegate?.updateWeather(with: weather)
            case .failure(let error):
                print(error)
            }
        }
    }
}
