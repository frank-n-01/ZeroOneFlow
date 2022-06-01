// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct CircleFlow: View {
    @ObservedObject var circle: CircleViewModel
    @State var center = UIScreen.centerPoint
    @State private var depth = 0
    @State private var count = FlowCount()
    @State private var height: CGFloat = UIScreen.main.bounds.height
    @State private var width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            circle.colors.bg.edgesIgnoringSafeArea(.all)
            
            ScreenSizeGetter(height: $height, width: $width)
            
            ForEach(0 ..< depth, id: \.self) { i in
                if i < count.value {
                    CircleParts(circle: circle, count: $count, center: $center)
                }
            }
        }
        .onAppear {
            depth = Int(round(circle.depth))
        }
        .onReceive(Timer.publish(every: circle.isFlowing ? circle.interval : 100,
                                 on: .current, in: .common).autoconnect()) { _ in
            guard circle.isFlowing else { return }
            count.increment()
        }
        .onChange(of: height) { newHeight in
            center.y = newHeight / 2
        }
        .onChange(of: width) { newWidth in
            center.x = newWidth / 2
        }
        .onChange(of: circle.isFlowing) { isFlowing in
            guard isFlowing else { return }
            count.value = 0
            depth = Int(round(circle.depth))
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
    @State private var position = UIScreen.getRandomPoint()
    @State private var angle: Double = 0.0
    @State private var isClockwise = false
    
    var body: some View {
        GeometryReader { _ in
            Text(content)
                .font(.system(size: circle.fonts.size, weight: weight, design: design))
                .foregroundColor(circle.colors.txt)
                .position(position)
                .rotationEffect(.degrees(angle))
                .onAppear {
                    withAnimation(.easeIn) {
                        setPosition()
                        content = ContentMaker.make(with: circle.contents)
                    }
                    design = circle.fonts.design.value
                    weight = circle.fonts.weight.value
                }
                .onChange(of: count.value) { _ in
                    withAnimation() {
                        rotate()
                    }
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
    
    private func setPosition() {
        if center.x < center.y {
            position.x = center.x
            position.y = center.y - CGFloat(count.value) * circle.gap
        } else {
            position.x = center.x - CGFloat(count.value) * circle.gap
            position.y = center.y
        }
    }
}
