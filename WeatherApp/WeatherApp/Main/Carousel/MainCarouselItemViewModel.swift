//
//  MainCarouselItemViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 06/02/24.
//

import Combine
import UIKit

class MainCarouselItemViewModel: MVVMViewModel{
    
    let data: WeatherForCity
        
    init(data: WeatherForCity, dataProvider: NetworkManagerProvider){
        self.data = data
        super.init(dataProvider: dataProvider)
    }
    
    var temperatureString: String?{
        guard let temperature = data.currentWeather?.current.tempC else { return nil }
        return String(format: "%.0f °C", temperature)
    }
    
    var lastUpdateString: String?{
        guard let lastUpdate = data.currentWeather?.current.lastUpdatedEpoch else { return nil }
        return "MAIN.APP.LAST_UPDATE".localized + Date(timeIntervalSince1970: lastUpdate).format(format: "HH:mm")
    }
    
    var mainNameString: String{
        guard let name = data.currentWeather?.location.name else {
            return data.city.capitalized
        }
        return name.capitalized
    }
    
    var currentWeatherCondition: String?{
        guard let currentWeather = data.currentWeather?.current.condition.text else {
            return data.error?.description
        }
        return currentWeather
    }
}
