//
//  ForecastWeatherAPI.swift
//  WeatherApp
//
//  Created by Andrea Massari on 28/02/24.
//

import UIKit

struct ForecastWeatherAPI: APIElement{
    typealias Output = WeatherModel

    let requestParams: ForecastWeatherInput
    
    var path: String{
        "/v1/forecast.json"
    }
    
    var queryParameters: [(String, Any)]?{
        [("q", requestParams.location), ("days", requestParams.days)]
    }
}

struct ForecastWeatherInput{
    let location: String
    let days: Int
}
