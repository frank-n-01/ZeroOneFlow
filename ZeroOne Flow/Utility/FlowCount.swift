// Copyright © 2022 Ni Fu. All rights reserved.

import Foundation

struct FlowCount {
    var value: Int = 0
    
    mutating func increment() {
        value += 1
        if value > 65534 { value = 1000 }
    }
}
