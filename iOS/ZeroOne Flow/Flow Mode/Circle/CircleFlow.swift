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
        .onReceive(Timer.publish(every: circle.interval, on: .current,
                                 in: .common).autoconnect()) { _ in
            guard circle.isFlowing else { return }
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
    @State private var content = ""
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    @State private var position = UIScreen.centerPoint
    @State private var angle: Double = 0.0
    @State private var isClockwise = false
    
    var body: some View {
        if circle.isFlowing {
            GeometryReader { _ in
                Text(content)
                    .font(.system(size: circle.fonts.size,
                                  weight: weight,
                                  design: design))
                    .foregroundColor(circle.colors.txt)
                    .position(position)
                    .onChange(of: count.value) { _ in
                        withAnimation(.easeIn) {
                            rotate()
                        }
                    }
                    .onAppear {
                        withAnimation(.easeIn) {
                            initPosition()
                            content = ContentMaker.make(with: circle.contents)
                        }
                        design = circle.fonts.design.value
                        weight = circle.fonts.weight.value
                    }
                    .rotationEffect(.degrees(angle))
            }
        }
    }
    
    private func rotate() {
        if isClockwise {
            angle += circle.rotationAngle
            if angle > 36000 {
                isClockwise.toggle()
            }
        } else {
            angle -= circle.rotationAngle
            if angle < 0 {
                isClockwise.toggle()
            }
        }
    }
    
    private func initPosition() {
        if center.x < center.y {
            position.x = center.x
            position.y = center.y - CGFloat(count.value) * circle.gap
        } else {
            position.x = center.x - CGFloat(count.value) * circle.gap
            position.y = center.y
        }
    }
}
