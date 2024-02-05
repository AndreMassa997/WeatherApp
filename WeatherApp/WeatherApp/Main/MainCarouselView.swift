//
//  MainCarouselView.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit

class MainCarouselView: UICollectionView {
    var data: [WeatherForCity]?{
        didSet{
            self.reloadData()
        }
    }
    
    convenience init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.init(frame: .zero, collectionViewLayout: layout)
        self.register(cellType: MainCarouselItem.self)
        self.delegate = self
        self.dataSource = self
        isPagingEnabled = true
    }
}

extension MainCarouselView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = self.data?[indexPath.row] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MainCarouselItem.self)
        cell.configure(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

class MainCarouselItem: UICollectionViewCell, Reusable{
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
        lbl.font = UIFont.systemFont(ofSize: 48, weight: .light)
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
    
    func configure(data: WeatherForCity){
        self.mainName.text = data.currentWeather?.location.name.capitalized
        self.currentWeather.text = data.currentWeather?.current.condition.text
        self.currentTemperature.text = data.temperatureString
        self.lastUpdatedLabel.text = data.lastUpdateString
        self.backgroundColor = data.backgroundColor
    }
}
