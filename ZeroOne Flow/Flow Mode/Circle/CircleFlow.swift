// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct CircleFlow: View {
    @ObservedObject var circle: CircleViewModel
    @State var centerX: CGFloat = UIScreen.main.bounds.width / 2
    @State var centerY: CGFloat = UIScreen.main.bounds.height / 2
    @State private var loop = 0
    @State private var count = 0
    
    var body: some View {
        ZStack {
            circle.colors.bg.edgesIgnoringSafeArea(.all)
            
            ForEach(0 ..< loop, id: \.self) { i in
                if i < count {
                    CircleParts(circle: circle, count: $count, centerX: $centerX, centerY: $centerY)
                }
            }
        }
        .onReceive(Timer.publish(every: circle.isFlowing ? circle.interval : 100, on: .current, in: .common).autoconnect()) { _ in
            counter()
        }
        .onChange(of: UIScreen.main.bounds) { bounds in
            centerX = bounds.width / 2
            centerY = bounds.height / 2
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
    @Binding var centerX: CGFloat
    @Binding var centerY:CGFloat
    @State private var content = ""
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    @State private var x = UIScreen.main.bounds.width / 2
    @State private var y = UIScreen.main.bounds.height / 2
    @State private var angle: Double = 0.0
    @State private var clockwise = false
    
    var body: some View {
        if circle.isFlowing {
            GeometryReader { geometry in
                Text(content)
                    .font(.system(size: circle.fonts.size, weight: weight, design: design))
                    .foregroundColor(circle.colors.txt)
                    .position(x: x, y: y)
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
        if clockwise {
            angle += circle.rotationAngle
            if angle > 36000 {
                clockwise.toggle()
            }
        } else {
            angle -= circle.rotationAngle
            if angle < 0 {
                clockwise.toggle()
            }
        }
    }
    
    private func initPosition() {
        if centerX < centerY {
            x = centerX
            y = centerY - CGFloat(count) * circle.gap
        } else {
            x = centerX - CGFloat(count) * circle.gap
            y = centerY
        }
    }
}
