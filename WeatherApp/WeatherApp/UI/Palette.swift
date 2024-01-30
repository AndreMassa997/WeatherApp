//
//  Palette.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit

protocol Palette{
    var paletteName: String { get }
    var statusBarStyle: UIStatusBarStyle { get }
    var barTintColor: UIColor { get }
    var barBackgroundColor: UIColor { get }
}

struct LightPalette: Palette{
    var paletteName: String {
        "light"
    }
    
    var statusBarStyle: UIStatusBarStyle{
        .darkContent
    }
    
    var barTintColor: UIColor{
        .black
    }
    
    var barBackgroundColor: UIColor{
        .white
    }
    
   
}

struct DarkPalette: Palette{
    var paletteName: String {
        "dark"
    }
    
    var barTintColor: UIColor{
        .white
    }
    
    var barBackgroundColor: UIColor{
        .black
    }
    
    var statusBarStyle: UIStatusBarStyle{
        .darkContent
    }
    
}
