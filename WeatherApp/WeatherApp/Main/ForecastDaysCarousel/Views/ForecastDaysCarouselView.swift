//
//  ForecastDaysCarousel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 12/03/24.
//

import UIKit

final class ForecastDaysCarouselView: UICollectionView {
    private var viewModel: ForecastDaysViewModel?
    
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        self.register(cellType: ForecastDayCollectionViewCell.self)
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
    
    func configure(viewModel: ForecastDaysViewModel){
        self.viewModel = viewModel
        self.reloadData()
    }
}

extension ForecastDaysCarouselView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel, let day = viewModel.dayForIndex(index: indexPath.item) else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ForecastDayCollectionViewCell.self)
        let forecastDayViewModel = ForecastDayItemViewModel(day: day, dataProvider: viewModel.dataProvider, imagesProvider: ImagesManager())
        cell.configure(viewModel: forecastDayViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        var cellWidth: CGFloat = collectionViewWidth
        if let viewModel{
            cellWidth = collectionViewWidth/CGFloat(viewModel.dataSource.count)
        }
        return CGSize(width: cellWidth, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
