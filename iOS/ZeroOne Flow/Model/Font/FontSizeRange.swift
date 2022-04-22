// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct FontSizeRange: Equatable {
    var min: CGFloat
    var max: CGFloat
    
    var range: ClosedRange<CGFloat> {
        return min...max
    }
    
    init(min: CGFloat, max: CGFloat) {
        self.min = min
        self.max = max
    }
    
    nonmutating func getRandomSizeInRange() -> CGFloat {
        return CGFloat.random(in: self.min...self.max)
    }
    
    mutating func set(min: CGFloat, max: CGFloat) {
        if min > 0 && min < max {
            self.min = min
            self.max = max
        }
    }
    
    nonmutating func save(min: inout Double, max: inout Double) {
        min = Double(self.min)
        max = Double(self.max)
    }
    
    mutating func random(max: CGFloat) {
        self.max = CGFloat.random(in: 20...max)
        self.min = CGFloat.random(in: 10...self.max)
    }
}
