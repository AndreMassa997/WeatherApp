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
    
    private func saveUserPreferences(name: String, value: Any){
        UserDefaults.standard.set(value, forKey: name)
    }
}
