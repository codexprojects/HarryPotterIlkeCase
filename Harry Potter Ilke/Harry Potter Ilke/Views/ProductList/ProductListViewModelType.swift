//
//  ProductListViewModelType.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import Combine

struct ProductListViewModelInput {
    /// called when a screen becomes visible
    let appear: AnyPublisher<Void, Never>
    // triggered when the search query is updated
    let search: AnyPublisher<Int, Never>
    /// called when the user selected an item from the list
    let selection: AnyPublisher<ProductList, Never>
}

enum ProductListState {
    case idle
    case loading
    case success([ProductList])
    case noResults
    case failure(Error)
}

extension ProductListState: Equatable {
    static func == (lhs: ProductListState, rhs: ProductListState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.success(let lhsProducts), .success(let rhsProducts)): return lhsProducts == rhsProducts
        case (.noResults, .noResults): return true
        case (.failure, .failure): return true
        default: return false
        }
    }
}

typealias ProductListViewModelOuput = AnyPublisher<ProductListState, Never>

protocol ProductListViewModelType {
    func transform(input: ProductListViewModelInput) -> ProductListViewModelOuput
}
