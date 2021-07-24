//
//  Log.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 24.07.2021.
//

import os.log
import Foundation

let oslog = Log()

struct Log {
    func success<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        log("🟢", object, file, function, line, .info)
    }
    
    func info<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        log("🟠", object, file, function, line, .info)
    }

    func error<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        log("🔴", object, file, function, line, .error)
    }
    
    private func log<T>(_ prefix: String, _ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line, _ logType: OSLogType) {
        #if DEBUG || QA || TESTING
        let fileName = (file as NSString).lastPathComponent
        let infoString: String = "\(prefix) -> \(fileName):\(function):[\(line)]: \(object)"
        os_log(logType, "%@", infoString)
        #endif
    }
    
    func serviceInfo<T>(_ object: T, spaceBefore: Bool = false, spaceAfter: Bool = false) {
        #if DEBUG || QA || TESTING
        var log = ""
        if spaceBefore { print("\n") }
        log += "🔵 \(object) 🔵"
        os_log(.debug, "%@", log)
        if spaceAfter { print("\n") }
        #endif
    }
}

