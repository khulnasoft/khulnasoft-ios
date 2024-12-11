//
//  Errors.swift
//  KhulnaSoft
//
//  Created by Ben White on 21.03.23.
//

import Foundation

struct InternalKhulnaSoftError: Error, CustomStringConvertible {
    let description: String

    init(description: String, fileID: StaticString = #fileID, line: UInt = #line) {
        self.description = "\(description) (\(fileID):\(line))"
    }
}
