//
//  ApplicationFlowCoordinatorTest.swift
//  Harry Potter IlkeTests
//
//  Created by Ilke Yucel on 26.07.2021.
//

import XCTest
import Foundation
@testable import Harry_Potter_Ilke

class ApplicationFlowCoordinatorTest: XCTestCase {

    private lazy var flowCoordinator = ApplicationFlowCoordinator(window: window, dependencyProvider: dependencyProvider)
    private let window =  UIWindow()
    private let dependencyProvider = ApplicationFlowCoordinatorDependencyProviderMock()

    /// Test that application flow is started correctly
    func test_startsApplicationsFlow() {
        // GIVEN
        let rootViewController = UINavigationController()
        dependencyProvider.productListNavigationControllerReturnValue = rootViewController

        // WHEN
        flowCoordinator.start()

        // THEN
        XCTAssertEqual(window.rootViewController, rootViewController)
    }

}

class ApplicationFlowCoordinatorDependencyProviderMock: ApplicationFlowCoordinatorDependencyProvider {

    var productListNavigationControllerReturnValue: UINavigationController?
    func productListNavigationController(navigator: ProductListNavigator) -> UINavigationController {
        return productListNavigationControllerReturnValue!
    }

    var productDetailControllerReturnValue: UIViewController?
    func productDetailsController(_ product: ProductList) -> UIViewController {
        return productDetailControllerReturnValue!
    }
}
