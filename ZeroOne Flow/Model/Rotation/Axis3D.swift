// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct Axis3D {
    var x: CGFloat = 0
    var y: CGFloat = 0
    var z: CGFloat = 0
    
    mutating func random() {
        self.x = CGFloat.random(in: -1.0...1.0)
        self.y = CGFloat.random(in: -1.0...1.0)
        self.z = CGFloat.random(in: -1.0...1.0)
    }
}
