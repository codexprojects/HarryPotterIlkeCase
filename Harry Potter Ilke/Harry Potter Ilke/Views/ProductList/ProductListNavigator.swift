//
//  ProductListNavigator.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import Foundation

protocol ProductListNavigator: AutoMockable, AnyObject {
    /// Presents the products details screen
    func showDetails(forProduct product: ProductList)

}
