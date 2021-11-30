// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct BigBangFlow: View {
    @ObservedObject var bigbang: BigBangViewModel
    @State private var loop = 0
    @State private var count = -15
    @State private var angle = 0.0
    @State private var isClockwise = false
    @State private var isMoving = false
    @State private var returnedCount = 0
    @State private var flow = BigBangFlowProperty()
    @State private var screen = ScreenSize()
    
    var body: some View {
        ZStack {
            bigbang.colors.bg.edgesIgnoringSafeArea(.all)
            screenSizeGetter // Get the screen size and initialize the properties.
            if isMoving { // Remove the elements when the flow stops. This is important to prevent the memory leak.
                elements.rotationEffect(.degrees(angle))
            } else {
                centerPoint
            }
        }
        .onAppear {
            self.loop = Int(bigbang.scale)
            flow.loop = self.loop
        }
        .onReceive(Timer.publish(every: bigbang.interval, on: .current, in: .common).autoconnect()) { _ in
            control()
        }
    }
    
    private var screenSizeGetter: some View {
        GeometryReader { geometry in
            Text("")
                .onAppear {
                    screen.setParameters(size: geometry.size, padding: bigbang.padding)
                    flow.initContent(with: bigbang.contents)
                    flow.initPosition(with: screen.center)
                    flow.initFontSize(range: bigbang.fonts.sizeRange.range)
                    flow.initFontDesign(design: bigbang.fonts.design)
                    flow.initFontWeight(weight: bigbang.fonts.weight)
                    flow.initAngle()
                    flow.initBools()
                    flow.initRotation3D()
                }
                .onChange(of: geometry.size) { _ in
                    screen.setParameters(size: geometry.size, padding: bigbang.padding)
                    flow.initPosition(with: screen.center)
                }
        }
    }
    
    private var elements: some View {
        ForEach(0 ..< loop, id: \.self) { i in
            Text(flow.content[i])
                .font(.system(size: !flow.isReturned[i] || count < 1 ? flow.size[i] : CGFloat(1.0),
                              weight: flow.weight[i],
                              design: flow.design[i]))
                .foregroundColor(bigbang.colors.txt)
                .position(flow.position[i])
                .rotationEffect(.degrees(flow.txtAngle[i]))
                .rotation3DEffect(.degrees(flow.rotation3D[i].angle) ,
                                  axis: (x: flow.rotation3D[i].axis.x, y: flow.rotation3D[i].axis.y, z: flow.rotation3D[i].axis.z),
                                  anchorZ: flow.rotation3D[i].anchorZ,
                                  perspective: flow.rotation3D[i].perspective)
        }
    }
    
    private var centerPoint: some View {
        Text("‧")
            .font(.system(size: 5.0, weight: .black))
            .foregroundColor(bigbang.colors.txt)
            .position(screen.center)
    }
    
    private func control() {
        count += 1
        if count == 0 { // Elements appear.
            isMoving.toggle()
        }
        if count == 1 { // Start expanding.
            withAnimation {
                bang()
            }
        }
        if count >= 1 { // Expanding and shrinking.
            if returnedCount < loop {
                withAnimation {
                    move()
                    rotate2D()
                    if bigbang.is3D {
                        rotate3D()
                    }
                }
            } else { // Restart
                isMoving.toggle()
                flow.toggle()
                count = -15
                returnedCount = 0
            }
        }
    }
    
    private func bang() {
        for i in (0 ..< loop) {
            flow.position[i].x += CGFloat.random(in: screen.bangRangeX)
            flow.position[i].y += CGFloat.random(in: screen.bangRangeY)
        }
    }
    
    private func move() {
        for i in (0 ..< loop) {
            if flow.isExpanding[i] {
                if !(screen.borderRangeX.contains(flow.position[i].x)) || !(screen.borderRangeY.contains(flow.position[i].y)) {
                    flow.isExpanding[i].toggle()
                } else {
                    if flow.position[i].x > screen.center.x {
                        flow.position[i].x += bigbang.gap
                    } else {
                        flow.position[i].x -= bigbang.gap
                    }

                    if flow.position[i].y > screen.center.y {
                        flow.position[i].y += bigbang.gap
                    } else {
                        flow.position[i].y -= bigbang.gap
                    }
                }
            } else {
                if (screen.centerRangeX.contains(flow.position[i].x)) && (screen.centerRangeY.contains(flow.position[i].y)) {
                    if !flow.isReturned[i] {
                        returnedCount += 1
                        flow.isReturned[i].toggle()
                        flow.position[i].x = screen.center.x
                        flow.position[i].y = screen.center.y
                    }
                } else {
                    if flow.position[i].x > screen.center.x {
                        flow.position[i].x -= CGFloat.random(in: 0...bigbang.gap)
                    } else {
                        flow.position[i].x += CGFloat.random(in: 0...bigbang.gap)
                    }

                    if flow.position[i].y > screen.center.y {
                        flow.position[i].y -= CGFloat.random(in: 0...bigbang.gap)
                    } else {
                        flow.position[i].y += CGFloat.random(in: 0...bigbang.gap)
                    }
                }
            }
        }
    }
    
    private func rotate2D() {
        if isClockwise {
            angle += bigbang.rotationAngle
            if angle > 3600 {
                isClockwise.toggle()
            }
        } else {
            angle -= bigbang.rotationAngle
            if angle < 0 {
                isClockwise.toggle()
            }
        }
    }
    
    private func rotate3D() {
        withAnimation {
            for i in (0 ..< loop) {
                flow.rotation3D[i].angle += Double.random(in: 0...bigbang.gap)
                if flow.rotation3D[i].angle > 3600 {
                    flow.rotation3D[i].angle -= 3600
                }
                flow.rotation3D[i].random()
                flow.rotation3D[i].random()
            }
        }
    }
}

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
        for _ in 0 ..< self.loop {
            self.content.append(ContentMaker.makeContent(with: contentType))
        }
    }
    
    mutating func initPosition(with center: CGPoint) {
        self.position = Array(repeating: center, count: self.loop)
    }
    
    mutating func initFontSize(range: ClosedRange<CGFloat>) {
        for _ in 0 ..< self.loop {
            self.size.append(CGFloat.random(in: range))
        }
    }
    
    mutating func initFontDesign(design: FontDesign) {
        if design == .random {
            for _ in 0 ..< self.loop {
                self.design.append(design.value)
            }
        } else {
            self.design = Array(repeating: design.value, count: self.loop)
        }
    }
    
    mutating func initFontWeight(weight: FontWeight) {
        if weight == .random {
            for _ in 0 ..< self.loop {
                self.weight.append(weight.value)
            }
        } else {
            self.weight = Array(repeating: weight.value, count: self.loop)
        }
    }
    
    mutating func initAngle() {
        for _ in 0 ..< self.loop {
            self.txtAngle.append(Double.random(in: 0 ..< 360))
        }
    }
    
    mutating func initBools() {
        self.isExpanding = Array(repeating: true, count: self.loop)
        self.isReturned = Array(repeating: false, count: self.loop)
    }
    
    mutating func initRotation3D() {
        self.rotation3D = Array(repeating: Rotation3D(), count: self.loop)
    }
    
    mutating func toggle() {
        for i in 0 ..< self.loop {
            self.isExpanding[i].toggle()
            self.isReturned[i].toggle()
        }
    }
}

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
        self.width = size.width
        self.height = size.height
        self.center = CGPoint(x: self.width / 2, y: self.height / 2)
        self.borderRangeX = padding.hor...(self.width - padding.hor)
        self.borderRangeY = padding.ver...(self.height - padding.ver)
        self.centerRangeX = (self.center.x - 5)...(self.center.x + 5)
        self.centerRangeY = (self.center.y - 5)...(self.center.y + 5)
        self.bangRangeX = -(self.width / 3)...(self.width / 3)
        self.bangRangeY = -(self.height / 3)...(self.height / 3)
    }
}

extension UIScreen {
    static func getScreenSize(smaller: Bool) -> CGFloat {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        if smaller {
            return width < height ? width : height
        } else {
            return width > height ? width : height
        }
    }
    
    static func getRandomPoint() -> CGPoint {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        return CGPoint(x: CGFloat.random(in: 0...width), y: CGFloat.random(in: 0...height))
    }
}
