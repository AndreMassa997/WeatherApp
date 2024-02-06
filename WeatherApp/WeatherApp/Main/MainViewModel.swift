//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import Combine
import UIKit

class MainViewModel: MVVMViewModel {
    
    @Published private(set) var weatherForCity: [WeatherForCity] = []
    @Published private(set) var currentPage: Int = 0
    
    var backgroundColor: UIColor?{
        guard !weatherForCity.isEmpty, let currentWeather = weatherForCity[currentPage].currentWeather else {
            return nil
        }
        return currentWeather.current.condition.code.getSkyColor(isDay: currentWeather.current._isDay)
    }
    
    private var cities: [String] = []
    
    func updateCurrentPage(_ page: Int?){
        guard let page else { return }
        self.currentPage = page
    }
    
    func getFirstTimeCity(){
        if let savedCities = AppPreferences.shared.savedCities{
            cities = savedCities
        }else{
            cities = ["London", "Paris", "Turin"]
        }
        
        Task{
            for city in cities {
                async let weather = self.dataProvider.getCurrentWeather(from: city)
                if let icon = await weather.weather?.current.condition.icon{
                    async let image = self.dataProvider.getImage(by: icon).image
                    await self.weatherForCity.append(WeatherForCity(currentWeather: weather.weather, error: weather.error, city: city, image: image))
                }else{
                    await self.weatherForCity.append(WeatherForCity(currentWeather: weather.weather, error: weather.error, city: city))
                }
            }
        }
    }
}
