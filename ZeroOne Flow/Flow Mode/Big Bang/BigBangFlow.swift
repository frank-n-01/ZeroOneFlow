// Copyright © 2021-2022 Ni Fu. All rights reserved.

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
            screenSizeGetter
            
            // Remove the elements when the flow stops.
            // This is necessary to prevent memory leaks.
            if isMoving {
                elements.rotationEffect(.degrees(angle))
            } else {
                centerPoint
            }
        }
        .onAppear {
            self.loop = Int(bigbang.scale)
            flow.loop = self.loop
        }
        .onReceive(Timer.publish(every: bigbang.interval,
                                 on: .current, in: .common).autoconnect()) { _ in
            control()
        }
    }
    
    /// Get the screen size and initialize the properties.
    private var screenSizeGetter: some View {
        GeometryReader { geometry in
            Text("")
                .onAppear {
                    screen.setParameters(size: geometry.size,
                                         padding: bigbang.padding)
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
                    screen.setParameters(size: geometry.size,
                                         padding: bigbang.padding)
                    flow.initPosition(with: screen.center)
                }
        }
    }
    
    /// The elements of the Big Bang.
    private var elements: some View {
        ForEach(0 ..< loop, id: \.self) { i in
            Text(flow.content[i])
                .font(.system(size: !flow.isReturned[i] || count < 1
                              ? flow.size[i] : CGFloat(1.0),
                              weight: flow.weight[i],
                              design: flow.design[i]))
                .foregroundColor(bigbang.colors.txt)
                .position(flow.position[i])
                .rotationEffect(.degrees(flow.txtAngle[i]))
                .rotation3DEffect(.degrees(flow.rotation3D[i].angle) ,
                                  axis: (x: flow.rotation3D[i].axis.x,
                                         y: flow.rotation3D[i].axis.y,
                                         z: flow.rotation3D[i].axis.z),
                                  anchorZ: flow.rotation3D[i].anchorZ,
                                  perspective: flow.rotation3D[i].perspective)
        }
    }
    
    /// A small origin point in the center.
    private var centerPoint: some View {
        Text("‧")
            .font(.system(size: 5.0, weight: .black))
            .foregroundColor(bigbang.colors.txt)
            .position(screen.center)
    }
    
    /// Control the animation of Big Bang.
    private func control() {
        count += 1
        // Elements appear.
        if count == 0 {
            isMoving.toggle()
        }
        // Start expanding.
        if count == 1 {
            withAnimation {
                bang()
            }
        }
        if count >= 1 {
            // Expanding and shrinking.
            if returnedCount < loop {
                withAnimation {
                    move()
                    rotate2D()
                    if bigbang.is3D {
                        rotate3D()
                    }
                }
            } else {
                // Restart when all the elements have returned to the origin.
                isMoving.toggle()
                flow.toggle()
                count = -15
                returnedCount = 0
            }
        }
    }
    
    /// The elements start expanding.
    private func bang() {
        for i in (0 ..< loop) {
            flow.position[i].x += CGFloat.random(in: screen.bangRangeX)
            flow.position[i].y += CGFloat.random(in: screen.bangRangeY)
        }
    }
    
    /// Expand to the limit and shrink back to the origin.
    private func move() {
        for i in (0 ..< loop) {
            if flow.isExpanding[i] {
                if !(screen.borderRangeX.contains(flow.position[i].x))
                    || !(screen.borderRangeY.contains(flow.position[i].y)) {
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
                if (screen.centerRangeX.contains(flow.position[i].x))
                    && (screen.centerRangeY.contains(flow.position[i].y)) {
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
