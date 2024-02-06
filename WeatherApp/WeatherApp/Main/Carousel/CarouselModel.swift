//
//  CarouselModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 06/02/24.
//

import UIKit

struct WeatherForCity{
    let currentWeather: CurrentWeather?
    let error: ErrorData?
    let city: String
    var image: UIImage?
}
