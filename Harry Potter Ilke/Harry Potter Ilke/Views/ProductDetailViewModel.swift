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
    let imageProcessor = AsyncImageProcessor()

    @objc func favoriteProductAction() {
        if let index = favoritesProducts?.productListFavorites.firstIndex(of: product) {
            favoritesProducts?.productListFavorites.remove(at: index)
            self.productDetailView?.favButton.setTitle("Add to Favorite", for: .normal)
            self.productDetailView?.favButton.backgroundColor = .systemGreen
        } else {
            favoritesProducts?.productListFavorites.append(product)
            self.productDetailView?.favButton.setTitle("Remove from Favorite", for: .normal)
            self.productDetailView?.favButton.backgroundColor = .red

        }

        favoritesProducts?.update()
    }

    func checkIsFav() {
        if let isFav = favoritesProducts?.checkProductIsFavorited(product: product),
           isFav {
            self.productDetailView?.favButton.setTitle("Remove from Favorite", for: .normal)
            self.productDetailView?.favButton.backgroundColor = .red
        } else {
            self.productDetailView?.favButton.setTitle("Add to Favorite", for: .normal)
            self.productDetailView?.favButton.backgroundColor = .systemGreen
        }
    }

    func setupView() {
        productDetailView = ProductDetailView(frame: UIScreen.main.bounds)

        favoritesProducts = FavoritesProducts()
        favoritesProducts?.load()
        productDetailView?.favButton.addTarget(self, action: #selector(favoriteProductAction), for: .touchUpInside)

        productDetailView?.author.text = "\(product.author ?? "")"
        productDetailView?.title.text = "\(product.title ?? "")"
    }

    func update(with image: UIImage?) {
        productDetailView?.imageView.image = image
    }

    func loadImage() {
        guard let imageURL = product.imageURL,
              let urlInstance = URL(string:
                                        imageURL.addingPercentEncoding(withAllowedCharacters:
                                                                        NSCharacterSet.urlQueryAllowed)!),
              let view = productDetailView else { return }

        let maxDimentionInPixels = getMaxDimentionInPixelsFrom(view.imageView, scale: 2.0)

        imageProcessor.downsampleAsync(product.uuid, imageURL: urlInstance,
                                       maxDimentionInPixels: maxDimentionInPixels) { image in
            DispatchQueue.main.async {
                self.update(with: image)
            }
        }
    }
}
