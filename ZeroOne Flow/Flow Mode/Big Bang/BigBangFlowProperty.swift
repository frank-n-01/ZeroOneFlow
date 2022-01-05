// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

/// The properties for the Biig Bang flow.
struct BigBangFlowProperty {
    var loop = 0
    var content: [String] = []
    var position: [CGPoint] = []
    var size: [CGFloat] = []
    var design: [Font.Design] = []
    var weight: [Font.Weight] = []
    var txtAngle: [Double] = []
    var isExpanding: [Bool] = []
    var isReturned: [Bool] = []
    var rotation3D: [Rotation3D] = []
    
    mutating func initContent(with contentType: Contents) {
        for _ in 0 ..< loop {
            content.append(ContentMaker.make(with: contentType))
        }
    }
    
    mutating func initPosition(with center: CGPoint) {
        position = Array(repeating: center, count: loop)
    }
    
    mutating func initFontSize(range: ClosedRange<CGFloat>) {
        for _ in 0 ..< loop {
            size.append(CGFloat.random(in: range))
        }
    }
    
    mutating func initFontDesign(design: FontDesign) {
        if design == .random {
            for _ in 0 ..< loop {
                self.design.append(design.value)
            }
        } else {
            self.design = Array(repeating: design.value, count: loop)
        }
    }
    
    mutating func initFontWeight(weight: FontWeight) {
        if weight == .random {
            for _ in 0 ..< loop {
                self.weight.append(weight.value)
            }
        } else {
            self.weight = Array(repeating: weight.value, count: loop)
        }
    }
    
    mutating func initAngle() {
        for _ in 0 ..< loop {
            txtAngle.append(Double.random(in: 0 ..< 360))
        }
    }
    
    mutating func initBools() {
        isExpanding = Array(repeating: true, count: loop)
        isReturned = Array(repeating: false, count: loop)
    }
    
    mutating func initRotation3D() {
        rotation3D = Array(repeating: Rotation3D(), count: loop)
    }
    
    /// Toglle the boolean properties.
    ///
    /// - isExpanding
    /// - isReturned
    mutating func toggle() {
        for i in 0 ..< loop {
            isExpanding[i].toggle()
            isReturned[i].toggle()
        }
    }
}

/// The screen size and border properties of the big bang flow.
struct ScreenSize {
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var center = CGPoint()
    var borderRangeX = CGFloat(0)...CGFloat(0)
    var borderRangeY = CGFloat(0)...CGFloat(0)
    var centerRangeX = CGFloat(0)...CGFloat(0)
    var centerRangeY = CGFloat(0)...CGFloat(0)
    var bangRangeX = CGFloat(0)...CGFloat(0)
    var bangRangeY = CGFloat(0)...CGFloat(0)
    
    mutating func setParameters(size: CGSize, padding: Padding) {
        width = size.width
        height = size.height
        center = CGPoint(x: width / 2, y: height / 2)
        borderRangeX = padding.hor...(width - padding.hor)
        borderRangeY = padding.ver...(height - padding.ver)
        centerRangeX = (center.x - 5)...(center.x + 5)
        centerRangeY = (center.y - 5)...(center.y + 5)
        bangRangeX = -(width / 3)...(width / 3)
        bangRangeY = -(height / 3)...(height / 3)
    }
}

extension UIScreen {
    
    /// Get the current screen size.
    ///
    /// - Parameter smaller: Return the smaller one or not.
    /// - Returns: The smaller or bigger one in the width and height.
    static func getSize(smaller: Bool) -> CGFloat {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        if smaller {
            return width < height ? width : height
        } else {
            return width > height ? width : height
        }
    }
    
    /// Get a random point on the screen.
    ///
    /// - Returns: A point with random position.
    static func getRandomPoint() -> CGPoint {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        return CGPoint(x: CGFloat.random(in: 0...width),
                       y: CGFloat.random(in: 0...height))
    }
}
