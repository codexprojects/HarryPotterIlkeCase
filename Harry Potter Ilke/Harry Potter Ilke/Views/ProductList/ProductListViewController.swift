//
//  ViewController.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 22.07.2021.
//

import UIKit
import Foundation
import Combine

 class ProductListViewController: UIViewController {

    init(viewModel: ProductListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Not supported!")
    }
    
    enum Section {
        case main
     }

    private let viewModel: ProductListViewModelType
    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, ProductList>! = nil
    
    private var cancellables: [AnyCancellable] = []
 
    private let selection = PassthroughSubject<Int, Never>()
    private let search = PassthroughSubject<String, Never>()
    private let appear = PassthroughSubject<Void, Never>()
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        bind(to: viewModel)
        configureDataSource()
        search.send("")
     }
 }

extension ProductListViewController {
 
    private func bind(to viewModel: ProductListViewModelType) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        let input = ProductListViewModelInput(appear: appear.eraseToAnyPublisher(),
                                               search: search.eraseToAnyPublisher(),
                                               selection: selection.eraseToAnyPublisher())

        let output = viewModel.transform(input: input)

        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }

    private func render(_ state: ProductListState) {
        switch state {
        case .idle:
            oslog.info("idle")
            update(with: [], animate: true)
        case .loading:
            oslog.info("loading")
            update(with: [], animate: true)
        case .noResults:
            oslog.info("noResults")
            update(with: [], animate: true)
        case .failure:
            oslog.error("failure")
            update(with: [], animate: true)
        case .success(let products):
            oslog.success("products count :\(products.count)")
            update(with: products, animate: true)
        }
    }
}

fileprivate extension ProductListViewController {
  
    func update(with products: [ProductList], animate: Bool = true) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, ProductList>()
            snapshot.appendSections([Section.main])
            snapshot.appendItems(products, toSection: .main)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}



