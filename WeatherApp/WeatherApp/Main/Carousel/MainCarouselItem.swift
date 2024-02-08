//
//  MainCarouselItem.swift
//  WeatherApp
//
//  Created by Andrea Massari on 06/02/24.
//

import UIKit

final class MainCarouselItem: UICollectionViewCell, Reusable{
    
    private var viewModel: MainCarouselItemViewModel?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var lastUpdatedLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return lbl
    }()
    
    private lazy var mainName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        return lbl
    }()
    
    private lazy var currentTemperature: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    private lazy var minMaxTemperature: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return lbl
    }()
    
    private lazy var currentWeather: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .medium)
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
        stackView.addArrangedSubview(lastUpdatedLabel)
        stackView.addArrangedSubview(mainName)
        stackView.addArrangedSubview(currentTemperature)
        stackView.addArrangedSubview(minMaxTemperature)
        stackView.addArrangedSubview(currentWeather)
        scrollView.addSubview(stackView)
        self.contentView.addSubview(scrollView)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.leftAnchor.constraint(greaterThanOrEqualTo: scrollView.leftAnchor, constant: 15),
            stackView.rightAnchor.constraint(lessThanOrEqualTo: scrollView.rightAnchor, constant: -15),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
        ])
    }

    
    func configure(viewModel: MainCarouselItemViewModel){
        self.viewModel = viewModel
        self.mainName.text = viewModel.mainNameString
        self.currentWeather.text = viewModel.currentWeatherCondition
        self.currentTemperature.attributedText = viewModel.temperatureString
        self.minMaxTemperature.text = viewModel.minMaxTemperature
        animateLastUpdatedLabel(text: viewModel.lastUpdateString)
    }
    
    private func animateLastUpdatedLabel(text: String?){
        lastUpdatedLabel.text = text
        
        let positionAnimation = CABasicAnimation(keyPath: "position.y")
        positionAnimation.fromValue = -lastUpdatedLabel.frame.height
        positionAnimation.toValue = 0
        positionAnimation.duration = 1.0
        
        lastUpdatedLabel.layer.add(positionAnimation, forKey: "move")

        // Rimuovi la label dopo l'animazione
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.lastUpdatedLabel.text = ""
        }
        
    }
}
