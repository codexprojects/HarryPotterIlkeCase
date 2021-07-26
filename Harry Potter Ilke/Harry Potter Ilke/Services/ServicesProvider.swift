//
//  ServicesProvider.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import Foundation

class ServicesProvider {
    let network: NetworkServiceType

    static func defaultProvider() -> ServicesProvider {
        let network = NetworkService()
        return ServicesProvider(network: network)
    }

    init(network: NetworkServiceType) {
        self.network = network
    }

}
