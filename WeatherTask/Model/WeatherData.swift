//
//  WeatherData.swift
//  WeatherTask
//
//  Created by Azik on 19.12.2022.
//

import Foundation

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
    
