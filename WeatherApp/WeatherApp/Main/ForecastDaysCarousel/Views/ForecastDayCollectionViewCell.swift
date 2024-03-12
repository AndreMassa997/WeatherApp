//
//  ForecastDayCollectionViewCell.swift
//  WeatherApp
//
//  Created by Andrea Massari on 12/03/24.
//

import UIKit

class ForecastDayCollectionViewCell: UICollectionViewCell, Reusable {
    private var viewModel: ForecastDayItemViewModel?
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return lbl
    }()
    
    private let weatherIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let maxTemperature: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return lbl
    }()
    
    private let minTemperature: UILabel = {
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
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(weatherIcon)
        stackView.addArrangedSubview(maxTemperature)
        stackView.addArrangedSubview(minTemperature)
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
    
    func configure(viewModel: ForecastDayItemViewModel){
        self.viewModel = viewModel
        self.dateLabel.text = viewModel.dayString
        self.minTemperature.text = viewModel.minTemperatureString
        self.maxTemperature.text = viewModel.maxTemperatureString
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
