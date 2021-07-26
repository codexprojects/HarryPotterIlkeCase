//
//  ProductListUseCaseTests.swift
//  Harry Potter IlkeTests
//
//  Created by Ilke Yucel on 26.07.2021.
//

import XCTest
import Foundation
import Combine
@testable import Harry_Potter_Ilke

class ProductListUseCaseTests: XCTestCase {

    private let networkService = NetworkServiceTypeMock()
    private var useCase: ProductListUseCase!
    private var cancellables: [AnyCancellable] = []

    override func setUp() {
        useCase = ProductListUseCase(networkService: networkService)
    }
    func test_getProductsSucceeds() {
        // Given
        var result: Result<[ProductList], Error>!
        let expectation = self.expectation(description: "Product List")
        // When -> Pagination Value
        useCase.getProducts(paginationValue: 0).sink { value in
            result = value
            expectation.fulfill()
        }.store(in: &cancellables)

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .success = result! else {
            XCTFail()
            return
        }
    }

}

class NetworkServiceTypeMock: NetworkServiceType {

    var loadCallsCount = 0
    var loadCalled: Bool {
        return loadCallsCount > 0
    }
    var responses = [String:Any]()

    func loadFromFile<T>(_ resource: ResourceFile<T>) -> AnyPublisher<T, Error> {
        let decoder = JSONDecoder()
        let jsonData = readFile(forName: resource.fileName)
        return Just(jsonData!)
            .decode(type: T.self, decoder: decoder)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
