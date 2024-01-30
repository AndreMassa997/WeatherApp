//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit

class MainViewController: BaseViewController<MainViewModel> {
    
    private lazy var carousel: MainCarouselView = {
        let carousel = MainCarouselView()
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .palette.barBackgroundColor
        pageControl.currentPageIndicatorTintColor = .palette.barTintColor
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "MAIN.APP.TITLE".localized
        setupView()
        setupConstraints()
    }
    
    private func setupView(){
        self.view.addSubview(carousel)
        self.view.addSubview(pageControl)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            carousel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            carousel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            carousel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            carousel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.leftAnchor.constraint(equalTo: view.leftAnchor),
            pageControl.rightAnchor.constraint(equalTo: view.rightAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            pageControl.bottomAnchor.constraint(equalTo: carousel.bottomAnchor),
        ])
    }
}

