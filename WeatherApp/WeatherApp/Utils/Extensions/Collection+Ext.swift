//
//  Collection+Ext.swift
//  WeatherApp
//
//  Created by Andrea Massari on 12/03/24.
//

import Foundation

extension Collection{
    subscript (safe index: Index) -> Element?{
        return indices.contains(index) ? self[index] : nil
    }
}
