//
//  ResourceFile.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import Foundation
import Combine


extension ResourceFile {
    static func products(fileName: String) -> ResourceFile<[ProductList]> {
        
        return ResourceFile<[ProductList]>(fileName: fileName)
    }
}

