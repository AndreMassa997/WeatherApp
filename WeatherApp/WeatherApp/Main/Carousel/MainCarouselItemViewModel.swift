//
//  MainCarouselItemViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 06/02/24.
//

import Combine
import UIKit

final class MainCarouselItemViewModel: MVVMViewModel{
    
    private let data: WeatherForCity
        
    init(data: WeatherForCity, dataProvider: NetworkProvider){
        self.data = data
        super.init(dataProvider: dataProvider)
    }
    
    var temperatureString: NSAttributedString?{
        guard let temperature = data.currentWeather?.current.tempC else { return nil
        }
        let mutableAttributed = NSMutableAttributedString(string: String(format: "%.0f", temperature), attributes: [.font: UIFont.systemFont(ofSize: 52, weight: .light)])
        mutableAttributed.append(NSAttributedString(string: " °C", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .light)]))
        return mutableAttributed
    }
    
    var lastUpdateString: String?{
        guard let lastUpdate = data.currentWeather?.current.lastUpdatedEpoch else { return nil }
        return "MAIN.APP.LAST_UPDATE".localized + Date(timeIntervalSince1970: lastUpdate).format(format: "HH:mm")
    }
    
    var mainNameString: String{
        guard let name = data.currentWeather?.location.name else {
            return data.city.name.capitalized
        }
        return name.capitalized
    }
    
    var currentWeatherCondition: String?{
        guard let currentWeather = data.currentWeather?.current.condition.text else {
            return data.error?.description
        }
        return currentWeather
    }
    
    var minMaxTemperature: String?{
        guard let minTemperature = data.currentWeather?.forecast.forecastday.first?.day.mintempC, let maxTemperature = data.currentWeather?.forecast.forecastday.first?.day.maxtempC else { return nil }
        return String(format: "%.0f / %.0f °C", minTemperature, maxTemperature)
    }
    
    var hourCarouselData: [Hour]?{
        data.currentWeather?.forecast.forecastday.first?.hour
    }
    
    var daysCarouselData: [ForecastDay]?{
        data.currentWeather?.forecast.forecastday
    }
}
