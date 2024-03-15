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
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(cellType: CityTableViewCell.self)
        tv.separatorStyle = .none
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SETTINGS".localized
        setupNavigationBar(hasLargeTitle: true)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        setupLayout()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

enum SettingsSections: Int, CaseIterable{
    case cities
    case temperature
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        SettingsSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = SettingsSections(rawValue: section)
        switch section{
        case .cities:
            return viewModel.cities.count
        case .temperature:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = SettingsSections(rawValue: indexPath.section)
        switch section{
        case .cities:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CityTableViewCell.self)
            let city = viewModel.cities[indexPath.row]
            let viewModel = CityViewModel(city: city, dataProvider: viewModel.dataProvider)
            cell.configure(viewModel: viewModel)
            return cell
        case .temperature:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
