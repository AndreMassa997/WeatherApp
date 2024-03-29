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
        guard let currentWeather = data.currentWeather else { return nil
        }
        let temperatureUnit = AppPreferences.shared.temperatureUnit
        let temperature = temperatureUnit == .celsius ? currentWeather.current.tempC : currentWeather.current.tempF
        let mutableAttributed = NSMutableAttributedString(string: String(format: "%.0f ", temperature), attributes: [.font: UIFont.systemFont(ofSize: 52, weight: .light)])
        mutableAttributed.append(NSAttributedString(string: temperatureUnit.rawValue, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .light)]))
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
        guard let day = data.currentWeather?.forecast.forecastday.first?.day else { return nil
        }
        let temperatureUnit = AppPreferences.shared.temperatureUnit
        let minTemperature = temperatureUnit == .celsius ? day.mintempC : day.mintempF
        let maxTemperature = temperatureUnit == .celsius ? day.maxtempC : day.maxtempF
        return String(format: "%.0f / %.0f %@", minTemperature, maxTemperature, temperatureUnit.rawValue)
    }
    
    var hourCarouselData: [Hour]?{
        data.currentWeather?.forecast.forecastday.first?.hour
    }
    
    var daysCarouselData: [ForecastDay]?{
        data.currentWeather?.forecast.forecastday
    }
}
