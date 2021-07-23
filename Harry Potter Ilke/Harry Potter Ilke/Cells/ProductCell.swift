//
//  TextCell.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 23.07.2021.
//

import UIKit

class ProductCell: UICollectionViewCell {
    let title = UILabel()
    static let reuseIdentifier = "text-cell-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
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
        
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontForContentSizeCategory = true
        contentView.addSubview(title)
        title.font = UIFont.preferredFont(forTextStyle: .caption1)
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
            ])
        title.textAlignment = .center
        title.font = UIFont.preferredFont(forTextStyle: .title3)
        title.text = "\(productItem?.title ?? "no title")"
        
        
    }
}

