//
//  AppPreferences.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import Foundation

class AppPreferences{
    
    static let shared = AppPreferences()
    
    var palette: Palette = LightPalette(){
        didSet{
            saveUserPreferences(name: "palette", value: palette.paletteName)
        }
    }
    
    var savedCities: [String]?{
        set{
            guard let citiesToSave = newValue?.joined(separator: "|") else { return }
            saveUserPreferences(name: "cities", value: citiesToSave)
        }
        get{
            guard let joinedCity = getUserPreferences(name: "cities") as? String else { return nil }
            return joinedCity.components(separatedBy: "|")
        }
    }
    
    var numberOfDays: Int{
        return 5
    }
    
    private func saveUserPreferences(name: String, value: Any){
        UserDefaults.standard.set(value, forKey: name)
    }
    
    private func getUserPreferences(name: String) -> Any?{
        UserDefaults.standard.object(forKey: name)
    }
}
