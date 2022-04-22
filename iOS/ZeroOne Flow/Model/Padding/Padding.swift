// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct Padding: Equatable {
    var ver: CGFloat
    var hor: CGFloat
    var min: CGFloat
    var max: CGFloat
    
    init(vertical: CGFloat, horizontal: CGFloat, min: CGFloat, max: CGFloat) {
        self.ver = vertical
        self.hor = horizontal
        
        if min <= max {
            self.min = min
            self.max = max
        } else {
            self.min = max
            self.max = min
        }
    }
    
    init(vertical: CGFloat, horizontal: CGFloat) {
        let max = UIScreen.getSize(smaller: true) / 2 - 50
        
        self.init(vertical: vertical, horizontal: horizontal,
                  min: -(max * 1.5), max: max)
    }
    
    mutating func set(vertical: Double, horizontal: Double) {
        self.ver = CGFloat(vertical)
        self.hor = CGFloat(horizontal)
    }
    
    nonmutating func save(vertical: inout Double, horizontal: inout Double) {
        vertical = Double(self.ver)
        horizontal = Double(self.hor)
    }
    
    mutating func random() {
        self.ver = CGFloat.random(in: min...0)
        self.hor = CGFloat.random(in: min...0)
    }
}
