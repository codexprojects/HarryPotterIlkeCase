//
//  ViewController.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 22.07.2021.
//

import UIKit
import Foundation

 class ProductListViewController: UIViewController {

    enum Section {
        case main
     }

    var dataSource: UICollectionViewDiffableDataSource<Section, ProductList>! = nil
    var collectionView: UICollectionView! = nil
    
    // initial data
    var data:[ProductList] = []
    var indexOfPageRequest = 1
    var loadingStatus = false
    var myPaginationUpperLimit = 2000
    var arrayCount = 0
    
     override func viewDidLoad() {
        super.viewDidLoad()
        print("welcome")
        navigationItem.title = "Harry Potter"
        configureHierarchy()
        loadData()
     }
 }

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
        data = getData()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
     }
    
    func getData() -> [ProductList] {
       
        guard let jsonData = readFile(forName: "products") else {
            return [] }
        let results = try! JSONDecoder().decode([ProductList].self, from: jsonData)
        
        return results
    }
    
    func configureDataSource(pageIndex: Int) {
        let cellRegistration = UICollectionView.CellRegistration<ProductCell, ProductList> { (cell, indexPath, identifier) in
         // Populate the cell with our item description.
       
            cell.productItem = identifier
            
        }
     
        dataSource = UICollectionViewDiffableDataSource<Section, ProductList>(collectionView: collectionView) {
         (collectionView: UICollectionView, indexPath: IndexPath, identifier: ProductList) -> UICollectionViewCell? in
         // Return the cell.
         return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, ProductList>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(data.prefix(pageIndex * 20)))
        arrayCount = snapshot.numberOfItems
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func loadMoreData() {
        let newArray = data[(arrayCount)...(indexOfPageRequest*20)]
        print(newArray.count)
        print(newArray.first?.title as Any)
     
        var snapshot = NSDiffableDataSourceSectionSnapshot<ProductList>()
        snapshot.append(Array(newArray))
        
        dataSource.reorderingHandlers.didReorder = { [weak self] transaction in
            guard let self = self else { return }
            
            self.dataSource.apply(snapshot, to: .main)
                //arrayCount = arrayCount + newArray.count
            
        }
        
       
        
    }
    
}

extension ProductListViewController: UICollectionViewDelegate {

    func loadData(){
        print("indexOfPageRequest \(indexOfPageRequest)")
        configureDataSource(pageIndex: indexOfPageRequest)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if indexPath.row + 1 == arrayCount && arrayCount < myPaginationUpperLimit {
            indexOfPageRequest += 1
            loadMoreData()
            print("load more")
        }
    }


}

extension ProductListViewController {
    private func readFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}
