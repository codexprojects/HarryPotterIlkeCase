//
//  NetworkService.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import Foundation
import Combine

final class NetworkService: NetworkServiceType {
    private let session: URLSession

    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral)) {
        self.session = session
    }

    //MARK: Read data from local json file.
    @discardableResult
    func loadFromFile<T>(_ resource: ResourceFile<T>) -> AnyPublisher<T, Error> {
        let decoder = JSONDecoder()
        let jsonData = readFile(forName: resource.fileName)
        return Just(jsonData!)
            .decode(type: T.self, decoder: decoder)
            .map { $0 }
            .eraseToAnyPublisher()
    }

}

