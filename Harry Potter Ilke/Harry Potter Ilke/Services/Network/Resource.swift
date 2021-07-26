//
//  Resource.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import Foundation

struct ResourceFile<T: Decodable> {
    let fileName : String
  
    init(fileName: String) {
        self.fileName = fileName
    }
}

