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
    
    @RawRapresentableUserDefault(key: "temperatureUnit", defaultValue: TemperatureUnit.celsius.rawValue) var temperatureUnit: TemperatureUnit
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

enum TemperatureUnit: String{
    case celsius = "°C"
    case fahrenheit = "°F"
}

@propertyWrapper
struct RawRapresentableUserDefault<Value: RawRepresentable>{
    let key: String
    let defaultValue: Value.RawValue
    
    var wrappedValue: Value{
        get{
            let rawValue: Value.RawValue = (UserDefaults.standard.object(forKey: key) ?? defaultValue) as! Value.RawValue
            return Value(rawValue: rawValue)!
        }
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: key)
        }
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
