//
//  ProductListViewModel.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import UIKit
import Combine

final class ProductListViewModel: ProductListViewModelType {

    private weak var navigator: ProductListNavigator?
    private let useCase: ProductListUseCaseType
    private var cancellables: [AnyCancellable] = []

    init(useCase: ProductListUseCaseType, navigator: ProductListNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }

    func transform(input: ProductListViewModelInput) -> ProductListViewModelOuput {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()

//        input.selection
//            .sink(receiveValue: { [unowned self] movieId in self.navigator?.showDetails(forMovie: movieId) })
//            .store(in: &cancellables)

        let searchInput = input.search
            .debounce(for: .milliseconds(300), scheduler: Scheduler.mainScheduler)
            .removeDuplicates()
        let products = searchInput
            .flatMapLatest({[unowned self] query in self.useCase.getProducts() })
            .map({ result -> ProductListState in
                switch result {
                case .success(let products) where products.isEmpty: return .noResults
                case .success(let products): return .success(products)
                case .failure(let error): return .failure(error)
                }
            })
            .eraseToAnyPublisher()

        let initialState: ProductListViewModelOuput = .just(.idle)
        let emptySearchString: ProductListViewModelOuput = searchInput.filter({ $0.isEmpty }).map({ _ in .idle }).eraseToAnyPublisher()
        let idle: ProductListViewModelOuput = Publishers.Merge(initialState, emptySearchString).eraseToAnyPublisher()

        return Publishers.Merge(idle, products).removeDuplicates().eraseToAnyPublisher()
    }

}
