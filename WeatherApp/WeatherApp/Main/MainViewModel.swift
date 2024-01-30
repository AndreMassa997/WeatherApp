//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import Combine

class MainViewModel: MVVMViewModel {
    
    @Published var weatherForCity: [(CurrentWeather?, ErrorData?)] = []
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
                await self.weatherForCity.append(weather)
            }
        }
    }
}
