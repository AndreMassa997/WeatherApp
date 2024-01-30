//
//  MainCarouselView.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit

class MainCarouselView: UICollectionView {

    
    convenience init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        isPagingEnabled = true
    }
}

class MainCarouselItem: UICollectionViewCell{
    private let mainIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "227")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
}
