//
//  ForecastHourCarouselView.swift
//  WeatherApp
//
//  Created by Andrea Massari on 08/02/24.
//

import UIKit

final class ForecastHourCarouselView: UICollectionView {
    
    private var viewModel: ForecastHoursViewModel?
    
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        self.register(cellType: ForecastHourItemCollectionViewCell.self)
        self.delegate = self
        self.dataSource = self
        self.layer.cornerRadius = 15
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = .white.withAlphaComponent(0.5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: ForecastHoursViewModel){
        self.viewModel = viewModel
        self.reloadData()
    }
}

extension ForecastHourCarouselView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel, let hour = viewModel.hourForIndex(index: indexPath.item) else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ForecastHourItemCollectionViewCell.self)
        let forecasHourItemViewModel = ForecastHourItemViewModel(hour: hour, dataProvider: viewModel.dataProvider, imagesProvider: ImagesManager())
        cell.configure(viewModel: forecasHourItemViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 70, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
