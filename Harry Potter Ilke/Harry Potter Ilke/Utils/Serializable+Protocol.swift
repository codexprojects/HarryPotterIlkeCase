//
//  Serializable+Protocol.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 25.07.2021.
//

import Foundation

public protocol Serializable: Codable {

    func serialize() -> Data?

    func toJSONObject() -> [String: Any]?

    func toJSONString() -> String?

    func decodeToObject(data: Data?) -> Serializable?

}

extension Serializable {

    public func serialize() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }

    public func toJSONObject() -> [String: Any]? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                return json
            }
            return nil
        } catch let err {
            oslog.error("Parsing Error: ", err.localizedDescription)
            return nil
        }
    }

    public func toJSONString() -> String? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(self)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            return jsonString
        } catch let err {
            oslog.error("Parsing Error: ", err.localizedDescription)
            return nil
        }
    }

    public func decodeToObject(data: Data?) -> Serializable? {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
          //  decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            return try decoder.decode(Self.self, from: data!)
        } catch let err {
            oslog.error("Parsing Error: ", err.localizedDescription)
            return nil
        }
    }
}

// extension Serializable where Self: AppModel {}
