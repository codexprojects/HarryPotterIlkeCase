//
//  ProductDetailViewControlller.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import UIKit
import Combine

class ProductDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var favButton: UIButton = {
        let button = UIButton()
        button.setTitle("Fav", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    func setup() {
        self.backgroundColor = .white
        addSubview(imageView)
        addSubview(favButton)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        favButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            
            favButton.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            favButton.widthAnchor.constraint(equalToConstant: 84),
            favButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}




class ProductDetailViewControlller: UIViewController {
        
    var viewImpl: ProductDetailView?
    
    var product: ProductList?
    
    var favoritesProducts: FavoritesProducts?

    override func loadView() {
        super.loadView()
        viewImpl = ProductDetailView(frame: UIScreen.main.bounds)
        self.view = viewImpl
        
        favoritesProducts = FavoritesProducts()
        favoritesProducts?.load()
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
        oslog.info("this is product detail!")
        oslog.info(product?.title)
        
        self.viewImpl?.favButton.addTarget(self, action: #selector(favoriteProduct), for: .touchUpInside)
        checkIsFav()
    }
    
    @objc func favoriteProduct() {
        guard let product = self.product else { return }
        
        if let index = favoritesProducts?.productListFavorites.firstIndex(of: product) {
            favoritesProducts?.productListFavorites.remove(at: index)
            self.viewImpl?.favButton.setTitle("Fav", for: .normal)
        } else {
            favoritesProducts?.productListFavorites.append(product)
            self.viewImpl?.favButton.setTitle("UnFav", for: .normal)
        }

        favoritesProducts?.update()
    }
    
    func checkIsFav() {
        guard let product = self.product else { return }
        if let isFav = favoritesProducts?.checkProductIsFavorited(product: product),
           isFav {
            self.viewImpl?.favButton.setTitle("UnFav", for: .normal)
        } else {
            self.viewImpl?.favButton.setTitle("Fav", for: .normal)
        }
    }
    
    func setNavigationBBar() {
        
    }
}
