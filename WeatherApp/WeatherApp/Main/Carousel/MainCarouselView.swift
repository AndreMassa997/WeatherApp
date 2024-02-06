//
//  MainCarouselView.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit

class MainCarouselView: UICollectionView {
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.viewModel = viewModel
        super.init(frame: .zero, collectionViewLayout: layout)
        self.register(cellType: MainCarouselItem.self)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .clear
        self.showsHorizontalScrollIndicator = false
        isPagingEnabled = true
        self.bindProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindProperties(){
        viewModel.$weatherForCity.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] data in
                self?.reloadData()
            })
            .store(in: &viewModel.anyCancellables)
    }
}

extension MainCarouselView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.weatherForCity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = viewModel.weatherForCity[indexPath.row]
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MainCarouselItem.self)
        cell.configure(viewModel: MainCarouselItemViewModel(data: data, dataProvider: viewModel.dataProvider))
        self.getItemAtCenterAndUpdatePage(from: collectionView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.getItemAtCenterAndUpdatePage(from: scrollView)
    }
    
    private func getItemAtCenterAndUpdatePage(from scrollView: UIScrollView){
        let xPoint = scrollView.contentOffset.x + scrollView.frame.width / 2
        let yPoint = scrollView.frame.height / 2
        let center = CGPoint(x: xPoint, y: yPoint)
        let indexPath = self.indexPathForItem(at: center)
        viewModel.updateCurrentPage(indexPath?.row)
    }
}
