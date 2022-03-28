// Copyright © 2021-2022 Ni Fu. All rights reserved.

import Foundation

class NumberMaker {
    static func make(type: NumberType) -> String {
        switch type {
        case .binary:
            return String(Int.random(in: 0...1))
        case .octal:
            return String(Int.random(in: 0...7))
        case .hexadecimal:
            return String(format: "%X", Int.random(in: 0...15))
        }
    }
}
