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
        guard weatherForCity.indices.contains(currentPage), let currentWeather = weatherForCity[currentPage].currentWeather else {
            return .lightGray
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
            cities = ["London", "Paris", "Berlin"]
        }
        
        self.reload()
    }
    
    func reloadAll(){
        self.reload()
    }
    
    private func reload(){
        Task{
            var tmpWeather: [WeatherForCity] = []
            for city in cities {
                async let weather = self.dataProvider.getForecastWeather(from: city, for: AppPreferences.shared.numberOfDays)
                await tmpWeather.append(WeatherForCity(currentWeather: weather.weather, error: weather.error, city: city))
                self.weatherForCity = tmpWeather
            }
        }
    }
}
