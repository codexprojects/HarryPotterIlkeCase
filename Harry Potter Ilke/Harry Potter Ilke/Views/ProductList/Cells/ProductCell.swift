//
//  TextCell.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 23.07.2021.
//

import UIKit

class ProductCell: UICollectionViewCell {
    var representedId: UUID?
    
    lazy var title : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .AvenirNextSemiBold(size: 12)
        label.textColor = UIColor(hex: "4A4A4A")
        return label
    }()
    
    lazy var author : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .AvenirNextRegular(size: 11)
        label.textColor = UIColor(hex: "4A4A4A")
        return label
    }()
    
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFit
        imageView.bounds.size = CGSize(width: 200, height: 300)
        return imageView
    }()
    

    lazy var isFavorite: UILabel = {
        let label = UILabel()
        label.text = ""
        label.backgroundColor = .systemGreen
        label.font = .AvenirNextRegular(size: 12)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

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
       
        //title label setup
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontForContentSizeCategory = true
        contentView.addSubview(title)
        
        let inset = CGFloat(10)
     
        //author label setup
        author.translatesAutoresizingMaskIntoConstraints = false
        author.adjustsFontForContentSizeCategory = true
        contentView.addSubview(author)
        
        //isFavorite label setup
        isFavorite.translatesAutoresizingMaskIntoConstraints = false
        isFavorite.adjustsFontForContentSizeCategory = true
        
        contentView.addSubview(isFavorite)
    
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
             
            isFavorite.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            isFavorite.widthAnchor.constraint(equalToConstant: 60),
            isFavorite.heightAnchor.constraint(equalToConstant: 30)
             
        ])

        author.text = "\(product.author ?? "")"
        title.text = "\(product.title ?? "")"
        
        if let isFav = favoritesProducts?.checkProductIsFavorited(product: product) {
            isFavorite.text = isFav ? "Favorited" : ""
            isFavorite.isHidden = isFav ? false : true
        }
  
    }
    
    func update(with image: UIImage?) {
        imageView.image = image
    }
}


