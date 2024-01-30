//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit

class MainViewController: BaseViewController<MainViewModel> {
    
    private let tabView: MainTabBar = {
        let tab = MainTabBar()
        tab.translatesAutoresizingMaskIntoConstraints = false
        return tab
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setupConstraints()
    }
    
    private func setupView(){
        self.view.addSubview(tabView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            tabView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tabView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tabView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


private class MainTabBar: UITabBar{
 
    private let mainIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "227")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    convenience init(){
        self.init(frame: .zero)
        self.addSubview(mainIcon)
        self.setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            mainIcon.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            mainIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainIcon.widthAnchor.constraint(equalToConstant: 100),
            mainIcon.heightAnchor.constraint(equalTo: mainIcon.widthAnchor)
        ])
    }
}

