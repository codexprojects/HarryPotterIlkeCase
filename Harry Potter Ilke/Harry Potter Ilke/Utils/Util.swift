//
//  Util.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 26.07.2021.
//

import UIKit

public func readFile(forName name: String) -> Data? {
    do {
        if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
            let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        }
    } catch {
        print(error)
    }
    return nil
}

public func slicePaginationArray(productList: [ProductList], page: Int) -> [ProductList] {
    if productList.isEmpty { return [] }
    let perPage = 20
    if (productList.count / perPage) <= page { return [] }
    let range = (page * perPage)..<((page + 1) * perPage)
    return Array(productList[range])
}

// MARK: Image helper
public func getMaxDimentionInPixelsFrom(_ imageView: UIImageView, scale: CGFloat) -> CGFloat {

    let imageViewSize = imageView.bounds.size
    return max(imageViewSize.width, imageViewSize.height) * scale
}
