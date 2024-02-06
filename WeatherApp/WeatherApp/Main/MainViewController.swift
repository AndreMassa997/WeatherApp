//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit
import Combine

class MainViewController: MVVMViewController<MainViewModel> {
    
    private lazy var carousel: MainCarouselView = {
        let carousel = MainCarouselView(viewModel: self.viewModel)
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .palette.barBackgroundColor
        pageControl.currentPageIndicatorTintColor = .palette.barTintColor
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override var isNavigationBarHidden: Bool{
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setupConstraints()
        viewModel.getFirstTimeCity()
    }
    
    override func bindProperties() {
        super.bindProperties()
        viewModel.$currentPage
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.updateView()
            })
            .store(in: &viewModel.anyCancellables)
    }
    
    private func setupView(){
        self.view.addSubview(carousel)
        self.view.addSubview(pageControl)
        self.view.backgroundColor = AppPreferences.shared.palette.barBackgroundColor
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            carousel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            carousel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            carousel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            carousel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.leftAnchor.constraint(equalTo: view.leftAnchor),
            pageControl.rightAnchor.constraint(equalTo: view.rightAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 25),
            pageControl.bottomAnchor.constraint(equalTo: carousel.bottomAnchor, constant: -10),
        ])
    }
    
    private func updateView(){
        pageControl.numberOfPages = viewModel.weatherForCity.count
        pageControl.currentPage = viewModel.currentPage
        self.view.backgroundColor = viewModel.backgroundColor
    }
}

