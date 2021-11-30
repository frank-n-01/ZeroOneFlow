// Copyright © 2021 Ni Fu. All rights reserved.

import Foundation

class NumberMaker {
    
    func makeNumber(numberType: NumberType) -> String {
        switch numberType {
        case .binary:
            return String(Int.random(in: 0...1))
        case .octal:
            return String(Int.random(in: 0...7))
        case .hexadecimal:
            return String(format: "%X", Int.random(in: 0...15))
        }
    }
}
