// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct TextFormat: Equatable {
    var isOn: Bool
    var value: Double
    
    init(isOn: Bool, value: Double) {
        self.isOn = isOn
        self.value = value
    }
    
    mutating func set(isOn: Bool, value: Double) {
        guard value > 0 else {
            self.set(isOn: isOn, value: 10)
            return
        }
        self.isOn = isOn
        self.value = value
    }
    
    nonmutating func save(isOn: inout Bool, value: inout Double) {
        isOn = self.isOn
        value = self.value
    }
    
    mutating func random(max: Int) {
        self.isOn = Bool.random()
        self.value = Double(Int.random(in: 1...max))
    }
}
