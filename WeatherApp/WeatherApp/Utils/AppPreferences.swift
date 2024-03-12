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
    
    @CodableUserDefault(key: "savedCities") var savedCities: [Location]?
    
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

@propertyWrapper
struct CodableUserDefault<Value: Codable>{
    let key: String
    
    var wrappedValue: Value?{
        get{
            guard 
                let data = UserDefaults.standard.object(forKey: key) as? Data,
                let decodedValue = try? JSONDecoder().decode(Value.self, from: data) else {
                return nil
            }
            return decodedValue
        }
        set{
            if let encoded = try? JSONEncoder().encode(newValue){
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}
