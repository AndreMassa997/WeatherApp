//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Andrea Massari on 12/03/24.
//

import UIKit

class SettingsViewController: MVVMViewController<SettingsViewModel> {
    override var isNavigationBarHidden: Bool{
        false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SETTINGS".localized
        setupNavigationBar(hasLargeTitle: true)
    }
}
