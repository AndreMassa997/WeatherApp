//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit
import Combine

class MainViewController: MVVMViewController<MainViewModel> {
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var carousel: MainCarouselView = {
        let carousel = MainCarouselView(viewModel: self.viewModel)
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.text = nil
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .palette.barBackgroundColor
        pageControl.currentPageIndicatorTintColor = .palette.barTintColor
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override var isNavigationBarHidden: Bool{
        true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setupConstraints()
        viewModel.getFirstTimeCity()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getCities()
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
        self.view.addSubview(settingsButton)
        self.view.addSubview(pageControl)
        self.carousel.refreshControl = refreshControl
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            carousel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            carousel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            carousel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            carousel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            settingsButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            settingsButton.widthAnchor.constraint(equalToConstant: 30),
            settingsButton.heightAnchor.constraint(equalTo: settingsButton.widthAnchor),
            pageControl.leftAnchor.constraint(equalTo: view.leftAnchor),
            pageControl.rightAnchor.constraint(equalTo: view.rightAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 25),
            pageControl.bottomAnchor.constraint(equalTo: carousel.bottomAnchor, constant: -10),
        ])
    }
    
    private func updateView(){
        pageControl.numberOfPages = viewModel.weatherForCity.count
        pageControl.currentPage = viewModel.currentPage
        UIView.animate(withDuration: 0.3, delay: 0, animations: { [weak self] in
            self?.view.backgroundColor = self?.viewModel.backgroundColor
        })
    }
    
    @objc private func handleRefresh(){
        self.carousel.refreshControl?.beginRefreshing()
        viewModel.reloadAll()
        self.carousel.refreshControl?.endRefreshing()
        self.carousel.scrollToItem(at: viewModel.currentPage)
    }
    
    @objc private func settingsTapped(){
        showBottomSheetSettings()
    }
    
    private func showBottomSheetSettings(){
        let bottomSheet = UIAlertController(title: "SETTINGS".localized, message: nil, preferredStyle: .actionSheet)
        bottomSheet.addAction(UIAlertAction(title: "SETTINGS.LOCATIONS_SETTINGS".localized, style: .default, handler: { [weak self] _ in
            self?.openLocationsSettings()
        }))
        bottomSheet.addAction(UIAlertAction(title: viewModel.setTemperatureMessage, style: .default, handler: { [weak self] _ in
            self?.viewModel.changeTemperatureUnit()
        }))
        
        bottomSheet.addAction(UIAlertAction(title: "CANCEL".localized, style: .cancel))
        self.present(bottomSheet, animated: true)
    }
    
    private func openLocationsSettings(){
        let locationsSettingsViewModel = LocationsSettingsViewModel(cities: viewModel.cities, dataProvider: viewModel.dataProvider)
        let locationsSettingsVC = LocationsSettingsViewController(viewModel: locationsSettingsViewModel)
        self.navigationController?.pushViewController(locationsSettingsVC, animated: true)
    }
}

