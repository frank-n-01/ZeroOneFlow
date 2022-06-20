// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct Padding: Equatable {
    var vertical: CGFloat
    var horizontal: CGFloat
    var min: CGFloat
    var max: CGFloat
    
    init(vertical: CGFloat, horizontal: CGFloat, min: CGFloat, max: CGFloat) {
        self.vertical = vertical
        self.horizontal = horizontal
        
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
        self.vertical = CGFloat(vertical)
        self.horizontal = CGFloat(horizontal)
    }
    
    nonmutating func save(vertical: inout Double, horizontal: inout Double) {
        vertical = Double(self.vertical)
        horizontal = Double(self.horizontal)
    }
    
    mutating func random() {
        guard min <= max else { return }
        self.vertical = CGFloat.random(in: min...max)
        self.horizontal = CGFloat.random(in: min...max)
    }
}
