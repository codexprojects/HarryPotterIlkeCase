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
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var favButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to Favorite", for: .normal)
        button.backgroundColor = .red
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


