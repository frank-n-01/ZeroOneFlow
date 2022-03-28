// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct Range: Equatable {
    var min: Double
    var max: Double
    
    var range: ClosedRange<Double> {
        return self.min...self.max
    }
    
    init(min: Double, max: Double) {
        if min <= max {
            self.min = min
            self.max = max
        } else {
            self.min = max
            self.max = min
        }
    }
    
    mutating func set(min: Double, max: Double) {
        guard min <= max else { return }
        self.min = min
        self.max = max
    }
    
    nonmutating func save(min: inout Double, max: inout Double) {
        min = self.min
        max = self.max
    }
    
    mutating func random(max: Double) {
        self.max = Double.random(in: 5...max)
        self.min = Double.random(in: 0...self.max)
    }
}
