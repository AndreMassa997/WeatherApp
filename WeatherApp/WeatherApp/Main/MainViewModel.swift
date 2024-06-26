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
    @Published private (set) var temperatureUnit: TemperatureUnit = AppPreferences.shared.temperatureUnit {
        willSet{
            AppPreferences.shared.temperatureUnit = newValue
        }
    }
    
    var cities: [Location] = []
    private lazy var getNoDataSavedLocation: [Location] = {
        return [
            Location(id: 2801268, name: "London", region: "City of London, Greater London", country: "United Kingdom", lat: 51.52, lon: -0.11),
            Location(id: 803267, name: "Paris", region: "Ile-de-France", country: "France", lat: 33.66, lon: -95.56)
        ]
    }()
    
    var backgroundColor: UIColor?{
        guard weatherForCity.indices.contains(currentPage), let currentWeather = weatherForCity[currentPage].currentWeather else {
            return .lightGray
        }
        return currentWeather.current.condition.code.getSkyColor(isDay: currentWeather.current._isDay)
    }
    
    var temperatureSettingsMessage: String{
        AppPreferences.shared.temperatureUnit == .celsius ? "SETTINGS.SET_TEMPERATURE_F".localized : "SETTINGS.SET_TEMPERATURE_C".localized
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
    
    func getCities(){
        guard let savedCities = AppPreferences.shared.savedCities, self.cities != savedCities else {
            return
        }
        self.cities = savedCities
        self.reloadAll()
    }
    
    func reloadAll(){
        self.reload()
    }
    
    func changeTemperatureUnit(){
        if temperatureUnit == .celsius{
            temperatureUnit = .fahrenheit
        }else{
            temperatureUnit = .celsius
        }
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
