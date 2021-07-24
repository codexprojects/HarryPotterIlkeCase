//
//  ThemeManager.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 23.07.2021.
//

import UIKit

enum AppFonts: String {
    case AvenirNextRegular    = "Avenir Next"
    case AvenirNextSemiBold   = "Avenir Next Condensed"
}

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
