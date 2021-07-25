//
//  ProductListViewController+Extensions.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import UIKit

extension ProductListViewController {
 /// - Tag: Inset
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                          heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                      subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension ProductListViewController {
    func configureHierarchy() {
        navigationItem.title = "Harry Potter"
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        self.snapshot.appendSections([Section.main])
        view.addSubview(collectionView)
     }

    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ProductCell, ProductList> { (cell, indexPath, identifier) in
         // Populate the cell with our item description.
            cell.productItem = identifier
        }

        dataSource = UICollectionViewDiffableDataSource<Section, ProductList>(collectionView: collectionView) {
         (collectionView: UICollectionView, indexPath: IndexPath, identifier: ProductList) -> UICollectionViewCell? in
         // Return the cell.
         return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }
}

extension ProductListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !self.paginantionEnabled &&
            indexPath.row + 1 == collectionView.numberOfItems(inSection: indexPath.section) {
            self.paginantionEnabled = true
            oslog.info("pagination will be set")
        }

       
    }

}

