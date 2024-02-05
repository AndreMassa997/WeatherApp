//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import Combine

class MainViewModel: MVVMViewModel {
    
    @Published var weatherForCity: [WeatherForCity] = []
    @Published var currentPage: Int = 0
    
    private var cities: [String] = []
    
    func getFirstTimeCity(){
        if let savedCities = AppPreferences.shared.savedCities{
            cities = savedCities
        }else{
            cities = ["London"]
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
