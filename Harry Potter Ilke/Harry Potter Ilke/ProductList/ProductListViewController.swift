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

    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil

     override func viewDidLoad() {
        super.viewDidLoad()
        print("welcome")
        navigationItem.title = "Product List"
        configureHierarchy()
        configureDataSource()
     }
 }

extension ProductListViewController {
 /// - Tag: Inset
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                          heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                      subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension ProductListViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
     }
    
    func getData() {
        let jsonData = readFile(forName: "products")
        let jsonResult = try! JSONSerialization.jsonObject(with: jsonData!, options: .mutableLeaves)
        print(jsonResult)
        
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<TextCell, Int> { (cell, indexPath, identifier) in
         // Populate the cell with our item description.
        cell.label.text = "\(identifier)"
        cell.contentView.backgroundColor = .systemPink
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.label.textAlignment = .center
        cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
        }
     
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
         (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
         // Return the cell.
         return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }

     // initial data
        getData()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<25))
        dataSource.apply(snapshot, animatingDifferences: false)
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
