//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Andrea Massari on 12/03/24.
//

import UIKit

class LocationsSettingsViewController: MVVMViewController<LocationsSettingsViewModel> {
    override var isNavigationBarHidden: Bool{
        false
    }
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(cellType: CityTableViewCell.self)
        tv.separatorStyle = .none
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SETTINGS.LOCATIONS_SETTINGS".localized
        setupNavigationBar(hasLargeTitle: true)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        setupLayout()
    }
    
    override func bindProperties() {
        viewModel.$cities
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &viewModel.anyCancellables)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    deinit{
        print("Settings view controller correctly deinit")
    }
}

extension LocationsSettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CityTableViewCell.self)
        let city = viewModel.cities[indexPath.row]
        let isDeleteButtonVisibile = viewModel.cities.count > 1
        let viewModel = CityViewModel(city: city, dataProvider: viewModel.dataProvider)
        cell.configure(viewModel: viewModel, isDeleteButtonVisible: isDeleteButtonVisibile)
        viewModel.deleteButtonTap
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] in
                self?.askForDeleteCityConfirmation(city: viewModel.city)
            }
            .store(in: &viewModel.anyCancellables)
        return cell
    }
    
    private func askForDeleteCityConfirmation(city: Location){
        let message = "SETTINGS.DELETE_CITY_MESSAGE".localized(with: city.name.capitalized)
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "CANCEL".localized, style: .cancel))
        alertController.addAction(UIAlertAction(title: "CONFIRM".localized, style: .destructive, handler: { [weak self] _ in
            self?.viewModel.deleteCity(city: city)
        }))
        self.present(alertController, animated: true)
    }
}
