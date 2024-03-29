//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Andrea Massari on 15/03/24.
//

import UIKit

class CityTableViewCell: UITableViewCell, Reusable {
    
    private let viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .palette.barTintColor.withAlphaComponent(0.05)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let locationLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let rightButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(nil, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private weak var viewModel: CityViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(){
        self.viewContainer.addSubview(locationLabel)
        self.viewContainer.addSubview(rightButton)
        self.contentView.addSubview(viewContainer)
        setupLayout()
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    func configure(viewModel: CityViewModel){
        locationLabel.text = viewModel.locationNameAndFlag
        rightButton.isHidden = viewModel.rightButtonHidden
        rightButton.setImage(UIImage(systemName: viewModel.rightButtonImageName), for: .normal)
        self.viewModel = viewModel
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            viewContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            viewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            viewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            viewContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),

            locationLabel.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: 15),
            locationLabel.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 10),
            locationLabel.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -10),
            locationLabel.rightAnchor.constraint(equalTo: rightButton.leftAnchor, constant: -10),
            
            rightButton.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            rightButton.rightAnchor.constraint(equalTo: viewContainer.rightAnchor, constant: -15),
            rightButton.widthAnchor.constraint(equalToConstant: 20),
            rightButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc private func rightButtonTapped(){
        viewModel?.rightButtonTap.send()
    }
}
