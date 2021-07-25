//
//  TextCell.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 23.07.2021.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    let title = UILabel()
    let author = UILabel()
    let imageView = UIImageView()
    let isFavorite = UILabel()

    static let reuseIdentifier = "text-cell-reuse-identifier"
    
    var favoritesProducts: FavoritesProducts?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        favoritesProducts = FavoritesProducts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var productItem: ProductList? {
        didSet {
            guard let product = productItem else { return }
            configure(product: product)
        }
    }

}

extension ProductCell {
    func configure(product: ProductList) {
        favoritesProducts?.load()

        contentView.backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        
        //imageview setup
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFit
      
        //title label setup
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontForContentSizeCategory = true
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        contentView.addSubview(title)
        
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
            ])
        title.textAlignment = .center
        title.font = .AvenirNextSemiBold(size: 12)
        title.textColor = UIColor(hex: "4A4A4A")
        title.text = "\(product.title ?? "")"
        
        //author label setup
        author.translatesAutoresizingMaskIntoConstraints = false
        author.adjustsFontForContentSizeCategory = true
        contentView.addSubview(author)
        
        author.textAlignment = .center
        author.font = .AvenirNextRegular(size: 11)
        author.textColor = UIColor(hex: "4A4A4A")
        author.text = "\(product.author ?? "")"
        
        //isFavorite label setup
        isFavorite.translatesAutoresizingMaskIntoConstraints = false
        isFavorite.adjustsFontForContentSizeCategory = true
        isFavorite.numberOfLines = 0
        isFavorite.lineBreakMode = .byWordWrapping
        contentView.addSubview(isFavorite)
       
        isFavorite.backgroundColor = .red
        
        if let isFav = favoritesProducts?.checkProductIsFavorited(product: product) {
            isFavorite.text = isFav ? "Unfav" : "Fav"
        }
        
        
         NSLayoutConstraint.activate([
             imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
             imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
             imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
             imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
             
             title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
             title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
             title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
             title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
             
             author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
             author.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
             author.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
             
             isFavorite.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
             isFavorite.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
             isFavorite.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
             isFavorite.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
             ])

        guard let imageURL = product.imageURL, let urlInstance = URL(string:imageURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!) else { return }
        imageView.kf.setImage(with: urlInstance)
    }
}

