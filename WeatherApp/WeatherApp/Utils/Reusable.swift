//
//  Reusable.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit

/// Reusable Protocol for UITableViewCell and UICollectionViewCell

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    // MARK: - Cells
    final func register<T: UITableViewCell>(cellType: T.Type) where T: Reusable {
        self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            preconditionFailure("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType). Check that the reuseIdentifier is set properly in your XIB/Storyboard and that you registered the cell for reuse.")
        }
        return cell
    }
}

// MARK: - UICollectionView

extension UICollectionView {
    
    // MARK: - Cells
    final func register<T: UICollectionViewCell>(cellType: T.Type) where T: Reusable {
        self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
        guard let typedCell = cell as? T else {
            preconditionFailure("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType). Check that the reuseIdentifier is set properly in your XIB/Storyboard and that you registered the cell for reuse.")
        }
        return typedCell
    }
}
