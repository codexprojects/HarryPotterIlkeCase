//
//  ProductDetailViewControlller.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import UIKit
import Combine

class ProductDetailViewControlller: UIViewController {

    private let viewModel: ProductDetailViewModel?

    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.viewModel?.setupView()
        self.view = self.viewModel?.productDetailView
        self.viewModel?.loadImage()
    }

    override func viewDidLoad() {
       super.viewDidLoad()
        self.viewModel?.checkIsFav()
    }

}
