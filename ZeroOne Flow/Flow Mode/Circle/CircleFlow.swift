// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct CircleFlow: View {
    @ObservedObject var circle: CircleViewModel
    @State var center = UIScreen.centerPoint
    @State private var loop = 0
    @State private var count = FlowCount()
    
    var body: some View {
        ZStack {
            circle.colors.bg.edgesIgnoringSafeArea(.all)
            
            ForEach(0 ..< loop, id: \.self) { i in
                if i < count.value {
                    CircleParts(circle: circle, count: $count, center: $center)
                }
            }
        }
        .onReceive(Timer.publish(every: circle.isFlowing ? circle.interval : 100,
                                 on: .current, in: .common).autoconnect()) { _ in
            count.increment()
        }
        .onChange(of: UIScreen.main.bounds) { _ in
            center = UIScreen.centerPoint
        }
        .onAppear {
            loop = Int(circle.depth)
        }
    }
}

struct CircleParts: View {
    @ObservedObject var circle: CircleViewModel
    @Binding var count: FlowCount
    @Binding var center: CGPoint
    @State private var flow = CircleFlowParameters()
    
    var body: some View {
        if circle.isFlowing {
            GeometryReader { _ in
                Text(flow.content)
                    .font(.system(size: circle.fonts.size,
                                  weight: flow.weight,
                                  design: flow.design))
                    .foregroundColor(circle.colors.txt)
                    .position(flow.position)
                    .onChange(of: count.value) { _ in
                        withAnimation(.easeIn) {
                            rotate()
                        }
                    }
                    .onAppear {
                        initPosition()
                        flow.content = ContentMaker.make(with: circle.contents)
                        flow.design = circle.fonts.design.value
                        flow.weight = circle.fonts.weight.value
                    }
                    .rotationEffect(.degrees(flow.angle))
            }
        }
    }
    
    private func rotate() {
        if flow.isClockwise {
            flow.angle += circle.rotationAngle
            if flow.angle > 36000 {
                flow.isClockwise.toggle()
            }
        } else {
            flow.angle -= circle.rotationAngle
            if flow.angle < 0 {
                flow.isClockwise.toggle()
            }
        }
    }
    
    private func initPosition() {
        if center.x < center.y {
            flow.position.x = center.x
            flow.position.y = center.y - CGFloat(count.value) * circle.gap
        } else {
            flow.position.x = center.x - CGFloat(count.value) * circle.gap
            flow.position.y = center.y
        }
    }
}

private struct CircleFlowParameters {
    var content = ""
    var design: Font.Design = .monospaced
    var weight: Font.Weight = .regular
    var position = UIScreen.centerPoint
    var angle: Double = 0.0
    var isClockwise = false
}

extension UIScreen {
    static var centerPoint: CGPoint {
        CGPoint(x: main.bounds.width / 2, y: main.bounds.height / 2)
    }
}
