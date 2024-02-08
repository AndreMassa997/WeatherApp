//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

///Models from https://www.weatherapi.com/api.aspx

import UIKit

struct WeatherModel: MVVMModel{
    let location: Location
    let current: Current
    let forecast: Forecast
}

struct Location: MVVMModel{
    let name: String
    let region: String
    let lat: Double
    let lon: Double
}

struct Current: MVVMModel{
    let lastUpdatedEpoch: TimeInterval
    let tempC: Double
    let condition: Condition
    let windKph: Double
    let isDay: Int
    
    var _isDay: Bool{
        return isDay == 1
    }
}

struct Forecast: MVVMModel{
    let forecastday: [ForecastDay]
}
        
struct ForecastDay: MVVMModel{
    let date: String
    let day: Day
    let hour: [Hour]
}

struct Day: MVVMModel{
    let condition: Condition
    let maxtempC: Double
    let mintempC: Double
}

struct Hour: MVVMModel{
    let time: String
    let tempC: Double
    let condition: Condition
}

struct Condition: MVVMModel{
    let icon: String
    let text: String
    let code: ConditionCode
}

enum ConditionCode: Int, MVVMModel {
    case sunny = 1000
    case partlyCloudy = 1003
    case cloudy = 1006
    case overcast = 1009
    case mist = 1030
    case patchyRainPossible = 1063
    case patchySnowPossible = 1066
    case patchySleetPossible = 1069
    case patchyFreezingDrizzlePossible = 1072
    case thunderyOutbreaksPossible = 1087
    case blowingSnow = 1114
    case blizzard = 1117
    case fog = 1135
    case freezingFog = 1147
    case patchyLightDrizzle = 1150
    case lightDrizzle = 1153
    case freezingDrizzle = 1168
    case heavyFreezingDrizzle = 1171
    case patchyLightRain = 1180
    case lightRain = 1183
    case moderateRainAtTimes = 1186
    case moderateRain = 1189
    case heavyRainAtTimes = 1192
    case heavyRain = 1195
    case lightFreezingRain = 1198
    case moderateOrHeavyFreezingRain = 1201
    case lightSleet = 1204
    case moderateOrHeavySleet = 1207
    case patchyLightSnow = 1210
    case lightSnow = 1213
    case patchyModerateSnow = 1216
    case moderateSnow = 1219
    case patchyHeavySnow = 1222
    case heavySnow = 1225
    case icePellets = 1237
    case lightRainShower = 1240
    case moderateOrHeavyRainShower = 1243
    case torrentialRainShower = 1246
    case lightSleetShowers = 1249
    case moderateOrHeavySleetShowers = 1252
    case lightSnowShowers = 1255
    case moderateOrHeavySnowShowers = 1258
    case lightShowersOfIcePellets = 1261
    case moderateOrHeavyShowersOfIcePellets = 1264
    case patchyLightRainWithThunder = 1273
    case moderateOrHeavyRainWithThunder = 1276
    case patchyLightSnowWithThunder = 1279
    case moderateOrHeavySnowWithThunder = 1282
    
    func getSkyColor(isDay: Bool) -> UIColor{
        return isDay ? skyColor : nightSkyColor
    }
    
    private var skyColor: UIColor {
        switch self {
        case .sunny:
            return #colorLiteral(red: 0.5294117647, green: 0.8078431373, blue: 0.9215686275, alpha: 1) // #87CDE6
        case .partlyCloudy:
            return #colorLiteral(red: 0.8941176471, green: 0.9411764706, blue: 0.968627451, alpha: 1) // #E5EEF7
        case .cloudy:
            return #colorLiteral(red: 0.7764705882, green: 0.8705882353, blue: 0.9333333333, alpha: 1) // #C7D9E9
        case .overcast:
            return #colorLiteral(red: 0.6666666667, green: 0.7843137255, blue: 0.8666666667, alpha: 1) // #A9C2D9
        case .mist:
            return #colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1) // #E5E5E5
        case .patchyRainPossible, .patchySnowPossible, .patchySleetPossible, .patchyFreezingDrizzlePossible, .thunderyOutbreaksPossible:
            return #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) // #CCCCCCCC
        case .blowingSnow, .blizzard:
            return #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1) // #E6E6E6
        case .fog, .freezingFog:
            return #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1) // #B2B2B2
        case .patchyLightDrizzle, .lightDrizzle, .freezingDrizzle, .heavyFreezingDrizzle:
            return #colorLiteral(red: 0.7019607843, green: 0.7764705882, blue: 0.8666666667, alpha: 1) // #B3C7D9
        case .patchyLightRain, .lightRain, .moderateRainAtTimes, .moderateRain, .heavyRainAtTimes, .heavyRain:
            return #colorLiteral(red: 0.6, green: 0.7019607843, blue: 0.8, alpha: 1) // #99B3CC
        case .lightFreezingRain, .moderateOrHeavyFreezingRain:
            return #colorLiteral(red: 0.5019607843, green: 0.6000000238, blue: 0.7019607843, alpha: 1) // #8099B3
        case .lightSleet, .moderateOrHeavySleet:
            return #colorLiteral(red: 0.6, green: 0.6, blue: 0.7, alpha: 1) // #9999B3
        case .patchyLightSnow, .lightSnow, .patchyModerateSnow, .moderateSnow, .patchyHeavySnow, .heavySnow:
            return #colorLiteral(red: 0.8, green: 0.8, blue: 0.9, alpha: 1) // #CCCCCC
        case .icePellets:
            return #colorLiteral(red: 0.7, green: 0.7, blue: 0.8, alpha: 1) // #B3B3CC
        case .lightRainShower, .moderateOrHeavyRainShower, .torrentialRainShower:
            return #colorLiteral(red: 0.5019607843, green: 0.6000000238, blue: 0.7019607843, alpha: 1) // #8099B3
        case .lightSleetShowers, .moderateOrHeavySleetShowers:
            return #colorLiteral(red: 0.400000006, green: 0.5019607843, blue: 0.6000000238, alpha: 1) // #668099
        case .lightSnowShowers, .moderateOrHeavySnowShowers:
            return #colorLiteral(red: 0.6, green: 0.6, blue: 0.7, alpha: 1) // #9999B3
        case .lightShowersOfIcePellets, .moderateOrHeavyShowersOfIcePellets:
            return #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.6000000238, alpha: 1) // #808099
        case .patchyLightRainWithThunder, .moderateOrHeavyRainWithThunder, .patchyLightSnowWithThunder, .moderateOrHeavySnowWithThunder:
            return #colorLiteral(red: 0.400000006, green: 0.5019607843, blue: 0.6000000238, alpha: 1) // #668099
        }
    }
    
    private var nightSkyColor: UIColor {
        switch self {
        case .sunny, .partlyCloudy, .cloudy, .overcast, .mist:
            return #colorLiteral(red: 0.2392559528, green: 0.2901960784, blue: 0.368627451, alpha: 1) // #3D4A5D
        case .patchyRainPossible, .patchySnowPossible, .patchySleetPossible, .patchyFreezingDrizzlePossible, .thunderyOutbreaksPossible:
            return #colorLiteral(red: 0.2980392157, green: 0.3490196078, blue: 0.431372549, alpha: 1) // #4C586E
        case .blowingSnow, .blizzard:
            return #colorLiteral(red: 0.3960784314, green: 0.4470588235, blue: 0.5254901961, alpha: 1) // #657285
        case .fog, .freezingFog:
            return #colorLiteral(red: 0.3450980392, green: 0.3450980392, blue: 0.3450980392, alpha: 1) // #585858
        case .patchyLightDrizzle, .lightDrizzle, .freezingDrizzle, .heavyFreezingDrizzle:
            return #colorLiteral(red: 0.2980392157, green: 0.3490196078, blue: 0.431372549, alpha: 1) // #4C586E
        case .patchyLightRain, .lightRain, .moderateRainAtTimes, .moderateRain, .heavyRainAtTimes, .heavyRain:
            return #colorLiteral(red: 0.2549019608, green: 0.2980392157, blue: 0.3803921569, alpha: 1) // #414C61
        case .lightFreezingRain, .moderateOrHeavyFreezingRain:
            return #colorLiteral(red: 0.200000003, green: 0.2509803922, blue: 0.3294117647, alpha: 1) // #334054
        case .lightSleet, .moderateOrHeavySleet:
            return #colorLiteral(red: 0.2509803922, green: 0.2509803922, blue: 0.3294117647, alpha: 1) // #3F3F54
        case .patchyLightSnow, .lightSnow, .patchyModerateSnow, .moderateSnow, .patchyHeavySnow, .heavySnow:
            return #colorLiteral(red: 0.3450980392, green: 0.3960784314, blue: 0.4784313725, alpha: 1) // #58657A
        case .icePellets:
            return #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.3803921569, alpha: 1) // #4C4C61
        case .lightRainShower, .moderateOrHeavyRainShower, .torrentialRainShower:
            return #colorLiteral(red: 0.200000003, green: 0.2509803922, blue: 0.3294117647, alpha: 1) // #334054
        case .lightSleetShowers, .moderateOrHeavySleetShowers:
            return #colorLiteral(red: 0.1490196078, green: 0.200000003, blue: 0.2784313725, alpha: 1) // #243345
        case .lightSnowShowers, .moderateOrHeavySnowShowers:
            return #colorLiteral(red: 0.2509803922, green: 0.2509803922, blue: 0.3294117647, alpha: 1) // #3F3F54
        case .lightShowersOfIcePellets, .moderateOrHeavyShowersOfIcePellets:
            return #colorLiteral(red: 0.200000003, green: 0.200000003, blue: 0.2784313725, alpha: 1) // #333345
        case .patchyLightRainWithThunder, .moderateOrHeavyRainWithThunder, .patchyLightSnowWithThunder, .moderateOrHeavySnowWithThunder:
            return #colorLiteral(red: 0.1490196078, green: 0.200000003, blue: 0.2784313725, alpha: 1) // #243345
        }
    }
            
}
