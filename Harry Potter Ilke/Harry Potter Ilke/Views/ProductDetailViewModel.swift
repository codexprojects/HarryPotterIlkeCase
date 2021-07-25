//
//  ProductDetailViewModel.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 25.07.2021.
//

import UIKit

class ProductDetailViewModel {

    private let product: ProductList

    init(product: ProductList) {
        self.product = product
    }
    
    var favoritesProducts: FavoritesProducts?
    var productDetailView: ProductDetailView?
    
    @objc func favoriteProductAction() {
        if let index = favoritesProducts?.productListFavorites.firstIndex(of: product) {
            favoritesProducts?.productListFavorites.remove(at: index)
            self.productDetailView?.favButton.setTitle("Add to Favorite", for: .normal)
        } else {
            favoritesProducts?.productListFavorites.append(product)
            self.productDetailView?.favButton.setTitle("Remove from Favorite", for: .normal)
        }

        favoritesProducts?.update()
    }
    
    func checkIsFav() {
        if let isFav = favoritesProducts?.checkProductIsFavorited(product: product),
           isFav {
            self.productDetailView?.favButton.setTitle("Remove from Favorite", for: .normal)
        } else {
            self.productDetailView?.favButton.setTitle("Add to Favorite", for: .normal)
        }
    }
    
    func setupView() {
        productDetailView = ProductDetailView(frame: UIScreen.main.bounds)
        
        favoritesProducts = FavoritesProducts()
        favoritesProducts?.load()
        
        productDetailView?.favButton.addTarget(self, action: #selector(favoriteProductAction), for: .touchUpInside)
    }
}
