//
//  UIColor+Ext.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit


extension UIColor{
    
    static var palette: Palette{
        AppPreferences.shared.palette
    }
    
}
