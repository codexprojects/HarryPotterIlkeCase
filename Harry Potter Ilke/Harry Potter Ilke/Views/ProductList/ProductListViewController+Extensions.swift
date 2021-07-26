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
        let cellRegistration = UICollectionView.CellRegistration<ProductCell, ProductList> { [self] (cell, indexPath, identifier) in
         // Populate the cell with our item description.
            cell.productItem = identifier
            
            // Image processing
            let maxDimentionInPixels = getMaxDimentionInPixelsFrom(cell, scale: collectionView.traitCollection.displayScale)
            cell.representedId = identifier.uuid
            
            if let downsampledImage = imageProcessor.downsampledImage(for: identifier.uuid) {
                cell.update(with: downsampledImage)
            }
            
            cell.update(with: nil)
            
            guard let imageURL = identifier.imageURL, let urlInstance = URL(string:imageURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!) else { return }
            
            imageProcessor.downsampleAsync(identifier.uuid, imageURL: urlInstance, maxDimentionInPixels: maxDimentionInPixels) { image in
                DispatchQueue.main.async {
                    guard cell.representedId == identifier.uuid else { return }
                    cell.update(with: image)
                }
            }
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

extension ProductListViewController {
    
    //MARK: Image helper
    private func getMaxDimentionInPixelsFrom(_ cell: ProductCell, scale: CGFloat) -> CGFloat {
        let imageViewSize = cell.imageView.bounds.size
       
        return max(imageViewSize.width, imageViewSize.height) * scale
    }
}
