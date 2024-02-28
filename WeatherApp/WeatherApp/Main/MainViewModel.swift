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
            for city in self.cities {
                async let weather = self.getForecast(for: city)
                //Make web call
                await tmpWeather.append(WeatherForCity(currentWeather: weather.result, error: weather.error, city: city))
                //Assign variable to change the UI
                self.weatherForCity = tmpWeather
            }
        }
    }
    
    private func getForecast(for city: String, days: Int = AppPreferences.shared.numberOfDays) async -> (result: WeatherModel?, error: ErrorData?){
        let request = ForecastWeatherAPI(requestParams: ForecastWeatherInput(location: city, days: days))
        return await self.dataProvider.fetchData(with: request)
    }
}
