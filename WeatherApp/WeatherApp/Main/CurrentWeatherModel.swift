//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit

struct WeatherForCity{
    let currentWeather: CurrentWeather?
    let error: ErrorData?
    let city: String
    var image: UIImage?
}

struct CurrentWeather: MVVMModel{
    let location: Location
    let current: Current
}

struct Location: MVVMModel{
    let name: String
    let region: String
    let lat: Double
    let lon: Double
}

struct Current: MVVMModel{
    let lastUpdated: String
    let tempC: Double
    let condition: Condition
    let windKph: Double
}

struct Condition: MVVMModel{
    let icon: String
    let text: String
    let code: Int
}
