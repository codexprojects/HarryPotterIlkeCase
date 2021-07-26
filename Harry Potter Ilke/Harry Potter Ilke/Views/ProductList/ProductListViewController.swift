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
    var snapshot = NSDiffableDataSourceSnapshot<Section, ProductList>()
    
    private var cancellables: [AnyCancellable] = []
 
    private let selection = PassthroughSubject<ProductList, Never>()
    private let search = PassthroughSubject<Int, Never>()
    private let appear = PassthroughSubject<Void, Never>()
    
    let imageProcessor = AsyncImageProcessor()
    
    
    // TODO: FIXTHIS -> Move to VM
    var currentPage: Int = 0
    
    var paginantionEnabled = false {
        didSet {
            if paginantionEnabled {
                loadMore()
            }
        }
    }
    
    func loadMore() {
        currentPage += 1
        search.send(currentPage)
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        bind(to: viewModel)
        configureDataSource()
        search.send(currentPage)
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
            paginantionEnabled = false
            update(with: products, animate: true)
        }
    }
}

fileprivate extension ProductListViewController {
  
    func update(with products: [ProductList], animate: Bool = true) {
        DispatchQueue.main.async {
            self.snapshot.appendItems(products, toSection: .main)
            self.dataSource.apply(self.snapshot, animatingDifferences: animate)
            oslog.info(self.collectionView.numberOfItems(inSection: 0))
            self.paginantionEnabled = false
        }
    }
}

extension ProductListViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        selection.send(snapshot.itemIdentifiers[indexPath.row])
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
