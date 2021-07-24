//
//  ProductListCase.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import Foundation
import Combine

protocol ProductListUseCaseType: AutoMockable {

    /// Runs movies search with a query string
    func getProducts() -> AnyPublisher<Result<[ProductList], Error>, Never>
}

final class ProductListUseCase: ProductListUseCaseType {

    private let networkService: NetworkServiceType

    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    
    }
    
    func getProducts() -> AnyPublisher<Result<[ProductList], Error>, Never> {
        return networkService
            .loadFromFile(ResourceFile<[ProductList]>.products(fileName: "products"))
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<[ProductList], Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }

}

