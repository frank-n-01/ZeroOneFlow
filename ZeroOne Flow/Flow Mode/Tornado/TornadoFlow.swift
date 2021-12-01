// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct TornadoFlow: View {
    @ObservedObject var tornado: TornadoViewModel
    @State private var duration = 0.0
    @State private var loop = 0
    @State private var angle = 0.0
    @State private var isClockwise = true
    @State private var count = 0
        
    var body: some View {
        ZStack {
            tornado.colors.bg.edgesIgnoringSafeArea(.all)
            
            ForEach(0 ..< loop, id: \.self) { i in
                if i < count {
                    TornadoParts(tornado: tornado, duration: $duration, count: $count)
                }
            }
            .rotationEffect(.degrees(angle))
        }
        .onAppear {
            loop = Int(tornado.scale)
            duration = Double.random(in: tornado.durationRange.range)
        }
        .onReceive(Timer.publish(every: tornado.isFlowing ? 0.1 : 100, on: .current, in: .common).autoconnect()) { _ in
            counter()
            
            withAnimation(.easeIn) {
                rotate()
            }
        }
    }
    
    private func counter() {
        count += 1
        // Change the duration of animation.
        if count % 10 == 0 {
            duration = Double.random(in: tornado.durationRange.range)
        }
        // Avoid over flow.
        if count > 10000 {
            count = 1000
        }
    }
    
    private func rotate() {
        if isClockwise {
            angle += Double.random(in: tornado.angleRange.range)
            
            if angle > 36000 {
                isClockwise.toggle()
            }
        } else {
            angle -= Double.random(in: tornado.angleRange.range)
            
            if angle < 0 {
                isClockwise.toggle()
            }
        }
    }
}

struct TornadoParts: View {
    @ObservedObject var tornado: TornadoViewModel
    @Binding var duration: Double
    @Binding var count: Int
    @State private var content = ""
    @State private var fontSize: CGFloat = 0
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    @State private var rotation3D = Rotation3D()
    @State private var position: CGPoint = UIScreen.getRandomPoint()
    
    var body: some View {
        if tornado.isFlowing {
            GeometryReader { geometry in
                Text(content)
                    .font(.system(size: fontSize, weight: weight, design: design))
                    .foregroundColor(tornado.colors.txt)
                    .position(position)
                    .rotation3DEffect(.degrees(rotation3D.angle),
                                      axis: (x: rotation3D.axis.x, y: rotation3D.axis.y, z: rotation3D.axis.z),
                                      anchorZ: rotation3D.anchorZ,
                                      perspective: rotation3D.perspective)
                    .onChange(of: count) { _ in
                        move(in: geometry.size)
                    }
                    .onAppear {
                        move(in: geometry.size)
                    }
            }
            .onAppear {
                content = ContentMaker.make(with: tornado.contents)
                fontSize = tornado.fonts.sizeRange.getRandomSizeInRange()
                design = tornado.fonts.design.value
                weight = tornado.fonts.weight.value
            }
        }
    }
    
    private func move(in size: CGSize) {
        
        withAnimation(.easeIn(duration: duration)) {
            position.x = CGFloat.random(in: 0...size.width)
            position.y = CGFloat.random(in: 0...size.height)
            rotation3D.random()
            rotation3D.angle += Double.random(in: tornado.angleRange.range)
            // Avoid over flow.
            if rotation3D.angle > 3600 {
                rotation3D.angle -= 3600
            }
        }
    }
}
