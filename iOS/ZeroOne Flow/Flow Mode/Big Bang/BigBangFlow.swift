// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct BigBangFlow: View {
    @ObservedObject var bigbang: BigBangViewModel
    @State private var flow = BigBangFlowParameters()
    @State private var screen = BigBangScreenSize()
    @State private var scale = 0
    @State private var count = FlowCount(value: BigBangViewModel.INITIAL_FLOW_COUNT)
    @State private var angle = 0.0
    @State private var isClockwise = false
    @State private var isMoving = false
    @State private var returnedCount = 0
    
    var body: some View {
        ZStack {
            bigbang.colors.bg.edgesIgnoringSafeArea(.all)
            screenSizeGetter
            
            // Remove the elements when the flow stops.
            // This is important to prevent memory leaks.
            if isMoving {
                elements.rotationEffect(.degrees(angle))
            } else {
                centerPoint
            }
        }
        .onAppear {
            self.scale = Int(round(bigbang.scale))
            flow.loop = self.scale
        }
        .onReceive(Timer.publish(every: bigbang.interval, on: .current,
                                 in: .common).autoconnect()) { _ in
            guard bigbang.isFlowing else { return }
            
            count.increment()
            
            if count.value == 0 {
                isMoving.toggle()
                return
            }
            
            if count.value == 1 {
                withAnimation {
                    bang()
                }
            }
            
            if count.value >= 1 {
                guard returnedCount < scale else {
                    isMoving.toggle()
                    flow.toggle()
                    count.value = BigBangViewModel.RETURNED_FLOW_COUNT
                    returnedCount = 0
                    return
                }
                
                withAnimation {
                    move()
                    rotate2D()
                    if bigbang.is3D {
                        rotate3D()
                    }
                }
            }
        }
    }
    
    /// Get the screen size and initialize the properties.
    private var screenSizeGetter: some View {
        GeometryReader { geometry in
            Text("")
                .onAppear {
                    screen.set(size: geometry.size, padding: bigbang.padding)
                    for _ in 0 ..< scale {
                        flow.content.append(ContentMaker.make(with: bigbang.contents))
                        flow.position = Array(repeating: screen.center, count: scale)
                        flow.size.append(CGFloat.random(in: bigbang.fonts.sizeRange.range))
                        flow.design.append(bigbang.fonts.design.value)
                        flow.weight.append(bigbang.fonts.weight.value)
                        flow.txtAngle.append(Double.random(in: 0 ..< 360))
                        flow.isExpanding = Array(repeating: true, count: scale)
                        flow.isReturned = Array(repeating: false, count: scale)
                        flow.rotation3D = Array(repeating: Rotation3D(), count: scale)
                    }
                }
                .onChange(of: geometry.size) { _ in
                    screen.set(size: geometry.size, padding: bigbang.padding)
                    flow.position = Array(repeating: screen.center, count: scale)
                }
        }
    }
    
    /// The elements of the Big Bang.
    private var elements: some View {
        ForEach(0 ..< scale, id: \.self) { i in
            Text(flow.content[i])
                .font(.system(size: !flow.isReturned[i] || count.value < 1
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
    
    private var centerPoint: some View {
        Text("‧")
            .font(.system(size: 5.0, weight: .black))
            .foregroundColor(bigbang.colors.txt)
            .position(screen.center)
    }
    
    private func bang() {
        for i in (0 ..< scale) {
            flow.position[i].x += CGFloat.random(in: screen.bangRangeX)
            flow.position[i].y += CGFloat.random(in: screen.bangRangeY)
        }
    }
    
    private func move() {
        for i in (0 ..< scale) {
            if flow.isExpanding[i] {
                guard screen.borderRangeX.contains(flow.position[i].x) &&
                        screen.borderRangeY.contains(flow.position[i].y) else {
                    flow.isExpanding[i].toggle()
                    return
                }
                
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
            } else {
                if (screen.centerRangeX.contains(flow.position[i].x)) &&
                    (screen.centerRangeY.contains(flow.position[i].y)) {
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
            for i in (0 ..< scale) {
                flow.rotation3D[i].angle += Double.random(in: 0...bigbang.gap)
                if flow.rotation3D[i].angle > 3600 {
                    flow.rotation3D[i].angle -= 3600
                }
                flow.rotation3D[i].random()
            }
        }
    }
}
