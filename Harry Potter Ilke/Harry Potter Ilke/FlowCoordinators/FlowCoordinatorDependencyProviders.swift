//
//  FlowCoordinatorDependencyProviders.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import UIKit

/// The `ApplicationFlowCoordinatorDependencyProvider` protocol defines methods to satisfy external dependencies of the ApplicationFlowCoordinator
protocol ApplicationFlowCoordinatorDependencyProvider: ProductListFlowCoordinatorDependencyProvider {}

protocol ProductListFlowCoordinatorDependencyProvider: AnyObject {
    /// Creates UIViewController to list products
    func productListNavigationController(navigator: ProductListNavigator) -> UINavigationController

   
}

