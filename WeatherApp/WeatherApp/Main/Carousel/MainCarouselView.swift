//
//  MainCarouselView.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit

class MainCarouselView: UICollectionView {    
    private var data: [WeatherForCity]?{
        didSet{
            self.reloadData()
        }
    }
    
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.viewModel = viewModel
        super.init(frame: .zero, collectionViewLayout: layout)
        self.register(cellType: MainCarouselItem.self)
        self.delegate = self
        self.dataSource = self
        isPagingEnabled = true
        self.bindProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindProperties(){
        viewModel.$weatherForCity.receive(on: DispatchQueue.main)
            .sink(receiveValue: { data in
                self.data = data
            })
            .store(in: &viewModel.anyCancellables)
    }
}

extension MainCarouselView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = self.data?[indexPath.row] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MainCarouselItem.self)
        cell.configure(viewModel: MainCarouselItemViewModel(data: data, dataProvider: viewModel.dataProvider))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
