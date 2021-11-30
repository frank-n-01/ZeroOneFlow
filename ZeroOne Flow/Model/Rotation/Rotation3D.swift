// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct Rotation3D {
    var angle: Double = 0.0
    var anchorZ: CGFloat = 0.0
    var perspective: CGFloat = 1.0
    var axis = Axis3D()
    
    mutating func random() {
        self.anchorZ = CGFloat.random(in: -100.0...100.0)
        self.perspective = CGFloat.random(in: -10.0...10.0)
        self.axis.random()
    }
}
