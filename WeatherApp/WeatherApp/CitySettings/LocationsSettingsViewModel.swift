//
//  SettingsViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 12/03/24.
//

import Combine

class LocationsSettingsViewModel: MVVMViewModel {

    @Published private(set) var cities: [Location]
    
    init(cities: [Location], dataProvider: NetworkProvider){
        self.cities = cities
        super.init(dataProvider: dataProvider)
    }
    
    func isRightButtonVisible(for city: Location) -> Bool{
        if let storedCities = AppPreferences.shared.savedCities, isCityAlreadyStored(for: city){
            return storedCities.count > 1
        }
        return true
    }
    
    func isCityAlreadyStored(for city: Location) -> Bool{
        AppPreferences.shared.savedCities?.contains(city) ?? false
    }
    
    func addOrDeleteCityTapped(city: Location){
        if isCityAlreadyStored(for: city){
            //Flow to delete
            deleteCity(city: city)
        }else{
            //Flow to add
            addCity(city: city)
        }
    }
    
    func searchCity(_ text: String){
        guard !text.isEmpty else {
            resetCities()
            return
        }
        //Then search cities
        Task{
            //Filter locally first
            var localCitiesFiltered = self.cities.filter({ $0.name.localizedCaseInsensitiveContains(text) })
            
            guard let remoteCities = await searchCitiesFromRemote(for: text).result else {
                return
            }
            localCitiesFiltered.append(contentsOf: remoteCities)
            self.cities = Array(Set(localCitiesFiltered))
        }
    }
    
    func messageForAddOrDeletePopup(for city: Location) -> String{
        let isCityAlreadyStored = isCityAlreadyStored(for: city)
        let addDelete = isCityAlreadyStored ? "SETTINGS.DELETE".localized : "SETTINGS.ADD".localized
        let fromTo = isCityAlreadyStored ? "SETTINGS.FROM".localized : "SETTINGS.TO".localized
        let message = "SETTINGS.CITY_MESSAGE_POPUP".localized(with: addDelete.lowercased(), "\(city.name.capitalized) - \(city.country.capitalized)", fromTo.lowercased())
        return message
    }
    
    private func searchCitiesFromRemote(for text: String) async -> (result: [Location]?, error: ErrorData?){
        let request = SearchCitiesAPI(requestParams: SearchCitiesInput(text: text))
        return await self.dataProvider.fetchData(with: request)
    }
    
    private func resetCities(){
        guard let storedCities = AppPreferences.shared.savedCities else {
            return
        }
        self.cities = storedCities
    }
    
    private func refreshCurrentCitiesState(){
        self.cities = cities
    }
    
    private func addCity(city: Location){
        AppPreferences.shared.savedCities?.append(city)
        refreshCurrentCitiesState()
    }
    
    private func deleteCity(city: Location){
        let newStoredCities = AppPreferences.shared.savedCities?.filter({ $0 != city })
        AppPreferences.shared.savedCities = newStoredCities
        refreshCurrentCitiesState()
    }
}
