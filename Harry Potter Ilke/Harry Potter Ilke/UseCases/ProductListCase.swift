//
//  ProductListCase.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import Foundation
import Combine

protocol ProductListUseCaseType: AutoMockable {

    /// Gets products from local file
    func getProducts(paginationValue: Int) -> AnyPublisher<Result<[ProductList], Error>, Never>
}

final class ProductListUseCase: ProductListUseCaseType {

    private let networkService: NetworkServiceType

    init(networkService: NetworkServiceType) {
        self.networkService = networkService

    }

    func getProducts(paginationValue: Int) -> AnyPublisher<Result<[ProductList], Error>, Never> {
        oslog.info(paginationValue)
        return networkService
            .loadFromFile(ResourceFile<[ProductList]>.products(fileName: "products"))
            .map { .success(slicePaginationArray(productList: $0, page: paginationValue)) }
            .catch { error -> AnyPublisher<Result<[ProductList], Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }

}
