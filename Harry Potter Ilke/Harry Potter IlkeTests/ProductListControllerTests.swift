////
////  ProductListControllerTests.swift
////  Harry Potter IlkeTests
////
////  Created by Ilke Yucel on 25.07.2021.
////
//
//@testable import Harry_Potter_Ilke
//import XCTest
//
//class ProductListControllerTests: XCTestCase {
//
//    var controller: ProductListViewController?
//    var dependencyProvider: ProductListFlowCoordinatorDependencyProvider?
//    var productListNavigationController: UINavigationController?
//    
//    override func setUpWithError() throws {
//        controller = ProductListViewController(nibName: nil, bundle: nil)
//        let servicesProvider: ServicesProvider = ServicesProvider.defaultProvider()
//        let useCase = ProductListUseCase(networkService: servicesProvider.network)
//    
//        
//        let productListNavigationController = dependencyProvider!.productListNavigationController(navigator: self)
//        self.productListNavigationController = productListNavigationController
//        controller?.viewDidLoad()
//    }
//    
//    func testViewModel() {
//        
//        
//    }
//
//
//}
//
//
//extension ProductListControllerTests: ProductListNavigator {
//
//    func showDetails(forProduct product: ProductList) {
//        guard let controller = self.dependencyProvider?.productDetailsController(product)
//        else { return }
//        productListNavigationController?.pushViewController(controller, animated: true)
//    }
//
//}
