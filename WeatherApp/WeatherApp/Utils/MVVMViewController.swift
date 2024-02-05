//
//  MVVMViewController.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit

class MVVMViewController<ViewModel: MVVMViewModel>: UIViewController{
    var viewModel: ViewModel
    
    var isNavigationBarHidden: Bool { get { return true }}
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Cannot load coder")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        bindProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = self.isNavigationBarHidden
    }
    
    func bindProperties() {
       
    }
  
    func setupNavigationBar(hasLargeTitle: Bool = false){
        self.navigationController?.navigationBar.tintColor = .palette.barTintColor
        self.navigationController?.navigationBar.backgroundColor = .palette.barBackgroundColor
        self.navigationController?.navigationBar.prefersLargeTitles = hasLargeTitle
    }
}
