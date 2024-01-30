//
//  ViewController.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit

protocol MVVMView{
    var viewModel: ViewModel { get }
}

class BaseViewController: UIViewController, MVVMView{
    var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Cannot load coder")
    }
}
