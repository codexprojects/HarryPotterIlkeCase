//
//  ProductListFlowCoordinator.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import UIKit

/// The `ProductListFlowCoordinator` takes control over the flows on the products list screen
class ProductListFlowCoordinator: FlowCoordinator {
    fileprivate let window: UIWindow
    fileprivate var productListNavigationController: UINavigationController?
    fileprivate let dependencyProvider: ProductListFlowCoordinatorDependencyProvider

    init(window: UIWindow, dependencyProvider: ProductListFlowCoordinatorDependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }

    func start() {
        let productListNavigationController = dependencyProvider.productListNavigationController(navigator: self)
        window.rootViewController = productListNavigationController
        self.productListNavigationController = productListNavigationController
    }
}

extension ProductListFlowCoordinator: ProductListNavigator {

    func showDetails(forProduct product: ProductList) {
        let controller = self.dependencyProvider.productDetailsController(product)
        productListNavigationController?.pushViewController(controller, animated: true)
    }

}
