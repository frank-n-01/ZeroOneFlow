// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct CircleFlow: View {
    @ObservedObject var circle: CircleViewModel
    @State var center = CGPoint(x: UIScreen.main.bounds.width / 2,
                                y: UIScreen.main.bounds.height / 2)
    @State private var loop = 0
    @State private var count = 0
    
    var body: some View {
        ZStack {
            circle.colors.bg.edgesIgnoringSafeArea(.all)
            
            ForEach(0 ..< loop, id: \.self) { i in
                if i < count {
                    CircleParts(circle: circle, count: $count, center: $center)
                }
            }
        }
        .onReceive(Timer.publish(every: circle.isFlowing ? circle.interval : 100,
                                 on: .current, in: .common).autoconnect()) { _ in
            counter()
        }
        .onChange(of: UIScreen.main.bounds) { bounds in
            center.x = bounds.width / 2
            center.y = bounds.height / 2
        }
        .onAppear {
            loop = Int(circle.depth)
        }
    }
    
    private func counter() {
        count += 1
        // Avoid over flow.
        if count > 100000 {
            count = 1000
        }
    }
}

struct CircleParts: View {
    @ObservedObject var circle: CircleViewModel
    @Binding var count: Int
    @Binding var center: CGPoint
    @State private var content = ""
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    @State private var position = CGPoint(x: UIScreen.main.bounds.width / 2,
                                          y: UIScreen.main.bounds.height / 2)
    @State private var angle: Double = 0.0
    @State private var isClockwise = false
    
    var body: some View {
        if circle.isFlowing {
            GeometryReader { geometry in
                Text(content)
                    .font(.system(size: circle.fonts.size,
                                  weight: weight,
                                  design: design))
                    .foregroundColor(circle.colors.txt)
                    .position(position)
                    .onChange(of: count) { _ in
                        withAnimation(.easeIn) {
                            rotate()
                        }
                    }
                    .onAppear {
                        initPosition()
                        content = ContentMaker.make(with: circle.contents)
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
            position.y = center.y - CGFloat(count) * circle.gap
        } else {
            position.x = center.x - CGFloat(count) * circle.gap
            position.y = center.y
        }
    }
}
