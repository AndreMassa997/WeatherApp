//
//  MainViewModel_Tests.swift
//  WeatherAppTests
//
//  Created by Andrea Massari on 30/03/24.
//

import XCTest
@testable import WeatherApp

final class MainViewModel_Tests: XCTestCase {
    
    func test_deleteAllCitiesStored_willReturnDefaultCities(){
        let stubbedNetworkProvider = StubbedNetworkProvider()
        let sut = MainViewModel(dataProvider: stubbedNetworkProvider)
        AppPreferences.shared.savedCities = nil
        sut.getFirstTimeCity()
        XCTAssertEqual(sut.cities.count, 2)
        //Store cities in appPreferences
        XCTAssertEqual(sut.cities.count, 2)
    }
    
    func test_removeOneCityFromStored_shoudReloadPage(){
        let stubbedNetworkProvider = StubbedNetworkProvider()
        let sut = MainViewModel(dataProvider: stubbedNetworkProvider)
        AppPreferences.shared.savedCities?.removeFirst()
        sut.getCities()
        XCTAssertEqual(sut.cities.count, 1)
    }
    
    func test_setTemperatureUnit_willStoreInAppPreference(){
        let stubbedNetworkProvider = StubbedNetworkProvider()
        let sut = MainViewModel(dataProvider: stubbedNetworkProvider)
        changeTemperatureUnitShouldReturnOther(sut)
        changeTemperatureUnitShouldReturnOther(sut)
    }
    
    private func changeTemperatureUnitShouldReturnOther(_ sut: MainViewModel){
        if sut.temperatureUnit == .celsius{
            sut.changeTemperatureUnit()
            XCTAssertTrue(AppPreferences.shared.temperatureUnit == .fahrenheit)
            XCTAssertTrue(sut.temperatureSettingsMessage == "SETTINGS.SET_TEMPERATURE_C".localized)
        }else{
            sut.changeTemperatureUnit()
            XCTAssertTrue(AppPreferences.shared.temperatureUnit == .celsius)
            XCTAssertTrue(sut.temperatureSettingsMessage == "SETTINGS.SET_TEMPERATURE_F".localized)
        }
    }
    
}

final class StubbedNetworkProvider: NetworkProvider{
    
    func fetchData<T>(with apiElement: T) async -> (result: T.Output?, error: WeatherApp.ErrorData?) where T : WeatherApp.APIElement {
        return (nil, .decodingError)
    }
    
    
}
