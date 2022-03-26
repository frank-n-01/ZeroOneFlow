// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct BigBangFlowParameters {
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
    
    mutating func toggle() {
        for i in 0 ..< loop {
            isExpanding[i].toggle()
            isReturned[i].toggle()
        }
    }
}

struct BigBangScreenSize {
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var center = CGPoint()
    var borderRangeX = CGFloat(0)...CGFloat(0)
    var borderRangeY = CGFloat(0)...CGFloat(0)
    var centerRangeX = CGFloat(0)...CGFloat(0)
    var centerRangeY = CGFloat(0)...CGFloat(0)
    var bangRangeX = CGFloat(0)...CGFloat(0)
    var bangRangeY = CGFloat(0)...CGFloat(0)
    
    mutating func set(size: CGSize, padding: Padding) {
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
    
    /// Get the the smaller or bigger one in the screen width and height.
    static func getSize(smaller: Bool) -> CGFloat {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        if smaller {
            return width < height ? width : height
        } else {
            return width > height ? width : height
        }
    }
    
    static func getRandomPoint() -> CGPoint {
        CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
    }
}
