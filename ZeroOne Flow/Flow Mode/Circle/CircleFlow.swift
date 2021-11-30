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
            
            ForEach(0 ..< self.loop, id: \.self) { i in
                if i < self.count {
                    CircleParts(circle: circle, count: $count, centerX: $centerX, centerY: $centerY)
                }
            }
        }
        .onReceive(Timer.publish(every: circle.start ? circle.interval : 100, on: .current, in: .common).autoconnect()) { _ in
            counter()
        }
        .onChange(of: UIScreen.main.bounds) { bounds in
            self.centerX = bounds.width / 2
            self.centerY = bounds.height / 2
        }
        .onAppear {
            self.loop = Int(circle.depth)
        }
    }
    
    private func counter() {
        self.count += 1
        if self.count > 1000000000 {
            self.count = 1000
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
        if circle.start {
            GeometryReader { geometry in
                Text(self.content)
                    .font(.system(size: circle.fonts.size, weight: self.weight, design: self.design))
                    .foregroundColor(circle.colors.txt)
                    .position(x: self.x, y: self.y)
                    .onChange(of: count) { _ in
                        withAnimation(.easeIn) {
                            moveRotation()
                        }
                    }
                    .onAppear {
                        makePosition()
                        self.content = ContentMaker.makeContent(with: circle.contents)
                        self.design = circle.fonts.design.value
                        self.weight = circle.fonts.weight.value
                    }
                    .rotationEffect(.degrees(self.angle))
            }
        }
    }
    
    private func moveRotation() {
        if self.clockwise {
            self.angle += circle.rotationAngle
            if self.angle > 36000 {
                self.clockwise.toggle()
            }
        } else {
            self.angle -= circle.rotationAngle
            if self.angle < 0 {
                self.clockwise.toggle()
            }
        }
    }
    
    private func makePosition() {
        if centerX < centerY {
            self.x = centerX
            self.y = centerY - CGFloat(count) * circle.gap
        } else {
            self.x = centerX - CGFloat(count) * circle.gap
            self.y = centerY
        }
    }
}
