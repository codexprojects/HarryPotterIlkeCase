//
//  NetworkServiceType.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import Foundation
import Combine

protocol NetworkServiceType: AnyObject {

    @discardableResult
    func loadFromFile<T>(_ resource: ResourceFile<T>) -> AnyPublisher<T, Error>
}

/// Defines the Network service errors.
enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case dataLoadingError(statusCode: Int, data: Data)
    case jsonDecodingError(error: Error)
}
