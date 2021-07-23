//
//  Data.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 23.07.2021.
//

import UIKit

public struct ProductList: Codable {
    let uuid = UUID()

    private enum CodingKeys : String, CodingKey { case title, author, imageURL }
    
    let title: String?
    let author: String?
    let imageURL: String?
}


// MARK: - Equatable
extension ProductList: Equatable {}

extension ProductList : Hashable {
    public static func ==(lhs: ProductList, rhs: ProductList) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
