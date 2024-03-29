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
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "SETTINGS.SEARCH_CITIES".localized
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.enablesReturnKeyAutomatically = false
        return sb
    }()
    
    private let tableView: UITableView = {
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
        searchBar.delegate = self
        self.view.addSubview(searchBar)
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
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),

            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
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
        let viewModel = CityViewModel(city: city, isRightButtonVisible: viewModel.isRightButtonVisible(for: city), isCityAlreadyStored: viewModel.isCityAlreadyStored(for: city), dataProvider: viewModel.dataProvider)
        cell.configure(viewModel: viewModel)
        viewModel.rightButtonTap
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] in
                self?.askForDeleteOrAddCityConfirmation(city: viewModel.city)
            }
            .store(in: &viewModel.anyCancellables)
        return cell
    }
    
    private func askForDeleteOrAddCityConfirmation(city: Location){
        let alertController = UIAlertController(title: nil, message: viewModel.messageForAddOrDeletePopup(for: city), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "CANCEL".localized, style: .cancel))
        alertController.addAction(UIAlertAction(title: "CONFIRM".localized, style: .destructive, handler: { [weak self] _ in
            self?.viewModel.addOrDeleteCityTapped(city: city)
        }))
        self.present(alertController, animated: true)
    }
}

extension LocationsSettingsViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCity(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
