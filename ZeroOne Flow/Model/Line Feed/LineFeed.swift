// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct LineFeed: Equatable {
    var isOn: Bool
    
    var maxLineLength: Int {
        didSet {
            self.maxLineLengthDouble = Double(self.maxLineLength)
        }
    }
    
    var maxLineLengthDouble: Double
    
    init(isOn: Bool, maxLineLength: Int) {
        self.isOn = isOn
        self.maxLineLength = maxLineLength
        self.maxLineLengthDouble = Double(self.maxLineLength)
    }
    
    mutating func set(isOn: Bool, maxLineLength: Int) {
        guard maxLineLength > 0 else {
            self.set(isOn: true, maxLineLength: 10)
            return
        }
        self.isOn = isOn
        self.maxLineLength = maxLineLength
    }
    
    nonmutating func save(isOn: inout Bool, maxLineLength: inout Int) {
        isOn = self.isOn
        maxLineLength = self.maxLineLength
    }
    
    nonmutating func save(isOn: inout Bool, maxLineLength: inout Int16) {
        isOn = self.isOn
        maxLineLength = Int16(self.maxLineLength)
    }
    
    mutating func random(maxOfMaxLineLength: Int) {
        self.isOn = true
        self.maxLineLength = Int.random(in: 1...maxOfMaxLineLength)
    }
}
