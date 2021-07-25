//
//  Data.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 23.07.2021.
//

import UIKit
import Combine

public struct ProductList: Codable {
    var uuid = UUID()

    private enum CodingKeys : String, CodingKey { case title, author, imageURL }
    
    var title: String?
    var author: String?
    var imageURL: String?
    
    init(title: String? = nil,
         author: String? = nil,
         imageURL: String? = nil) {
        self.title = title
        self.author = author
        self.imageURL = imageURL
    }
}


// MARK: - Equatable
extension ProductList: Equatable {}

// MARK: - Equatable
extension ProductList : Hashable {
    public static func == (lhs: ProductList, rhs: ProductList) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
