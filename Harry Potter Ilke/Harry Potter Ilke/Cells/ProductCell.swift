//
//  TextCell.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 23.07.2021.
//

import UIKit

class ProductCell: UICollectionViewCell {
    let title = UILabel()
    let author = UILabel()
    let imageView = UIImageView()
    
    static let reuseIdentifier = "text-cell-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    var productItem: ProductList? {
        didSet {
            configure()
        }
    }

}

extension ProductCell {
    func configure() {
        contentView.backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        
        //imageview setup
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
            ])
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
        title.text = "\(productItem?.title ?? "")"
        
        //author label setup
        author.translatesAutoresizingMaskIntoConstraints = false
        author.adjustsFontForContentSizeCategory = true
        contentView.addSubview(author)
       
        NSLayoutConstraint.activate([
            author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            author.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            author.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
            ])
        author.textAlignment = .center
        author.font = .AvenirNextRegular(size: 11)
        author.textColor = UIColor(hex: "4A4A4A")
        author.text = "\(productItem?.author ?? "")"
        
        guard let imageURL = productItem?.imageURL else { return }
        imageView.image = UIImage(data: try! Data(contentsOf: URL(string: imageURL)!))
    }
}

