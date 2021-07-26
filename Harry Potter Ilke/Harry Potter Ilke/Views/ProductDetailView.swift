//
//  ProductDetailView.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 25.07.2021.
//

import UIKit

class ProductDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFit
        imageView.bounds.size = CGSize(width: frame.width, height: frame.height)
        return imageView
    }()
    
    lazy var favButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to Favorite", for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = .AvenirNextRegular(size: 12)
        button.layer.cornerRadius = 5
        return button
    }()

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
    
    func setup() {
        self.backgroundColor = .white
        addSubview(imageView)
        addSubview(favButton)
        addSubview(title)
        addSubview(author)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        favButton.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        author.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            favButton.widthAnchor.constraint(equalToConstant: frame.width - 40),
            favButton.heightAnchor.constraint(equalToConstant: 45),
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            author.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            
        ])
        
        favButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        author.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    
}


