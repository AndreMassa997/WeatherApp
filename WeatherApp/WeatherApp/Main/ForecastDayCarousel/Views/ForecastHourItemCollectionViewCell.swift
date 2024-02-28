//
//  ForecastHourItemCollectionViewCell.swift
//  WeatherApp
//
//  Created by Andrea Massari on 08/02/24.
//

import UIKit

class ForecastHourItemCollectionViewCell: UICollectionViewCell, Reusable {
    private var viewModel: ForecastHourItemViewModel?
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var hourLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return lbl
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(){
        stackView.addArrangedSubview(hourLabel)
        stackView.addArrangedSubview(weatherIcon)
        stackView.addArrangedSubview(temperatureLabel)
        self.contentView.addSubview(stackView)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
    }
    
    func configure(viewModel: ForecastHourItemViewModel){
        self.viewModel = viewModel
        self.hourLabel.text = viewModel.hourString
        self.temperatureLabel.text = viewModel.temperatureString
        bindProperties()
    }
    
    func bindProperties(){
        guard let viewModel else { return }
        
        viewModel.$image.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] image in
                self?.weatherIcon.image = image
            })
            .store(in: &viewModel.anyCancellables)
    }
}
