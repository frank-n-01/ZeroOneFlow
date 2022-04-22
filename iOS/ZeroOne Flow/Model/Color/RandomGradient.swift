// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct RandomGradient {
    var type: GradientType
    var startColor: Color
    var endColor: Color
    var startRadius: CGFloat
    var endRadius: CGFloat
    let max: CGFloat
    var startPoint: UnitPoint
    var endPoint: UnitPoint
    var angle: Double
    var center: UnitPoint
    
    static let UNIT_POINTS: [UnitPoint] = [
        .top, .bottom, .leading, .trailing, .topLeading,
        .topTrailing, .bottomLeading, .bottomTrailing, .center]
    
    init(type: GradientType = .radial) {
        self.type = type
        self.startColor = Colors.random()
        self.endColor = Colors.random()
        self.startRadius = 5.0
        self.endRadius = 500.0
        self.max = UIScreen.getSize(smaller: false)
        self.startPoint = .bottom
        self.endPoint = .top
        self.angle = 90
        self.center = .center
    }
    
    mutating func random() {
        randomColor()
        switch type {
        case .radial:
            randomRadius()
        case .linear:
            randomPoint()
        case .angular:
            randomAngle()
            randomCenter()
        case .elliptical:
            randomCenter()
        }
    }
    
    mutating func randomColor() {
        startColor = Colors.random()
        endColor = Colors.random()
    }
    
    mutating func randomRadius() {
        endRadius = CGFloat.random(in: 0...max)
        startRadius = CGFloat.random(in: 0...endRadius)
    }
    
    mutating func randomPoint() {
        startPoint = RandomGradient.UNIT_POINTS.randomElement() ?? .bottom
        endPoint = RandomGradient.UNIT_POINTS.randomElement() ?? .top
    }
    
    mutating func randomAngle() {
        angle = Double.random(in: -270...450)
    }
    
    mutating func randomCenter() {
        center = RandomGradient.UNIT_POINTS[Int.random(in: 0...8)]
    }
}
