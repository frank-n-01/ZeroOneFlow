// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

/// Font properties of each flow mode.
struct Fonts: Equatable, Identifiable {
    var size: CGFloat
    var design: FontDesign
    var weight: FontWeight
    var sizeRange: FontSizeRange
    
    var id: UUID { return UUID()}
    
    init(size: CGFloat = 0, design: FontDesign = .monospaced, weight: FontWeight = .regular, min: CGFloat = 10, max: CGFloat = 50) {
        self.size = size
        self.design = design
        self.weight = weight
        self.sizeRange = FontSizeRange(min: min, max: max)
    }
    
    mutating func set(size: CGFloat? = nil, design: FontDesign, weight: FontWeight, min: CGFloat? = nil, max: CGFloat? = nil) {
        if let size = size { self.size = size }
        self.design = design
        self.weight = weight
        if let min = min, let max = max { self.sizeRange = FontSizeRange(min: min, max: max) }
    }
    
    mutating func set(size: CGFloat? = nil, design: Int, weight: Int, min: CGFloat? = nil, max: CGFloat? = nil) {
        if let size = size { self.size = size }
        self.design = FontDesign.init(rawValue: design) ?? .monospaced
        self.weight = FontWeight.init(rawValue: weight) ?? .regular
        if let min = min, let max = max { self.sizeRange = FontSizeRange(min: min, max: max) }
    }
    
    nonmutating func save(size: inout Double, design: inout Int16, weight: inout Int16) {
        size = Double(self.size)
        design = Int16(self.design.rawValue)
        weight = Int16(self.weight.rawValue)
    }
    
    mutating func random(min: CGFloat? = nil, max: CGFloat? = nil) {
        let designs = FontDesign.allCases
        let weights = FontWeight.allCases
        self.design = designs[Int.random(in: 0 ..< designs.count - 1)]
        self.weight = weights[Int.random(in: 0 ..< weights.count - 1)]
        self.size = sizeRange.getRandomSizeInRange()
        
        guard let min = min, let max = max else { return }
        guard min < max else { return }
        self.size = CGFloat.random(in: min...max)
    }
}
