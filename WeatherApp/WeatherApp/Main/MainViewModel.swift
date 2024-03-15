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
    
    var cities: [Location] = []
    private lazy var getNoDataSavedLocation: [Location] = {
        return [
            Location(name: "London", region: "City of London, Greater London", country: "United Kingdom", lat: 51.52, lon: -0.11),
            Location(name: "Paris", region: "Ile-de-France", country: "France", lat: 33.66, lon: -95.56),
            Location(name: "Berlin", region: "Berlin", country: "Germany", lat: 52.52, lon: 13.4),
        ]
    }()
    
    var backgroundColor: UIColor?{
        guard weatherForCity.indices.contains(currentPage), let currentWeather = weatherForCity[currentPage].currentWeather else {
            return .lightGray
        }
        return currentWeather.current.condition.code.getSkyColor(isDay: currentWeather.current._isDay)
    }
    
    
    func updateCurrentPage(_ page: Int?){
        guard let page else { return }
        self.currentPage = page
    }
    
    func getFirstTimeCity(){
        if let savedCities = AppPreferences.shared.savedCities{
            cities = savedCities
        }else{
            cities = getNoDataSavedLocation
            AppPreferences.shared.savedCities = cities
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
    
    private func getForecast(for city: Location, days: Int = AppPreferences.shared.numberOfDays) async -> (result: WeatherModel?, error: ErrorData?){
        let coordinates = "\(city.lat),\(city.lon)"
        let request = ForecastWeatherAPI(requestParams: ForecastWeatherInput(location: coordinates, days: days))
        return await self.dataProvider.fetchData(with: request)
    }
}
