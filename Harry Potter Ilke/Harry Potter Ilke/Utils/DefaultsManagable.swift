//
//  DefaultsManagable.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 25.07.2021.
//

import Foundation

public protocol DefaultsManageable {
    func update()
    mutating func load()
    func delete()
}

extension DefaultsManageable where Self: Serializable {

    public func update() {
        let jsonData = self.serialize()
        UserDefaults.standard.setValue(jsonData, forKey: "\(Self.self)")
    }

    mutating public func load() {
        guard let object = UserDefaults.standard.object(forKey: "\(Self.self)") as? Data
        else { return }
        do {
            let decoder = JSONDecoder()
            self = try decoder.decode(Self.self, from: object)
        } catch let error {
            dump(error)
            return
        }
    }

    public func delete() {
        UserDefaults.standard.removeObject(forKey: "\(Self.self)")
    }
}

struct FavoritesProducts: Serializable, DefaultsManageable {// Composed
    var productListFavorites: [ProductList] = []

    func checkProductIsFavorited(product: ProductList) -> Bool {
        if let index = self.productListFavorites.firstIndex(of: product) {
            oslog.info(index)
            return  true
        } else {
            return false
        }
    }

}
