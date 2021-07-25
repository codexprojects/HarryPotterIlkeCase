//
//  ApplicationComponentsFactory.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import UIKit

/// The ApplicationComponentsFactory takes responsibity of creating application components and establishing dependencies between them.
final class ApplicationComponentsFactory {
    fileprivate lazy var useCase: ProductListUseCaseType = ProductListUseCase(networkService: servicesProvider.network)

    private let servicesProvider: ServicesProvider

    init(servicesProvider: ServicesProvider = ServicesProvider.defaultProvider()) {
        self.servicesProvider = servicesProvider
    }
}

extension ApplicationComponentsFactory: ApplicationFlowCoordinatorDependencyProvider {
   
    func productListNavigationController(navigator: ProductListNavigator) -> UINavigationController {
        let viewModel = ProductListViewModel(useCase: useCase, navigator: navigator)
        let productListViewController = ProductListViewController(viewModel: viewModel)
        let productListNavigationController = UINavigationController(rootViewController: productListViewController)
        productListNavigationController.navigationBar.tintColor = .label
        return productListNavigationController
    }

    func productDetailsController(_ productId: Int) -> UIViewController {
        //let viewModel = MovieDetailsViewModel(movieId: movieId, useCase: useCase)
        return ProductDetailViewControlller() //MovieDetailsViewController(viewModel: viewModel)
    }
}

