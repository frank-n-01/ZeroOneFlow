// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct TornadoFlow: View {
    @ObservedObject var tornado: TornadoViewModel
    @State private var scale = 0
    @State private var count = FlowCount()
    @State private var duration = 0.0
    @State private var angle = 0.0
    @State private var isClockwise = true
        
    var body: some View {
        ZStack {
            tornado.colors.bg.edgesIgnoringSafeArea(.all)
            
            ForEach(0 ..< scale, id: \.self) { i in
                if i < count.value {
                    TornadoParts(tornado: tornado, duration: $duration, count: $count)
                }
            }
            .rotationEffect(.degrees(angle))
        }
        .onAppear {
            scale = Int(round(tornado.scale))
            duration = Double.random(in: tornado.durationRange.range)
            count.value = Int.random(in: 1...10)
        }
        .onChange(of: tornado.isFlowing) { isFlowing in
            guard isFlowing else { return }
            count.value = 0
            scale = Int(round(tornado.scale))
        }
        .onReceive(Timer.publish(every: tornado.isFlowing ? 0.1 : 100,
                                 on: .current, in: .common).autoconnect()) { _ in
            guard tornado.isFlowing else { return }
            count.increment()
            
            if count.value % 10 == 0 {
                duration = Double.random(in: tornado.durationRange.range)
            }
            withAnimation(.easeIn) {
                rotate()
            }
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
    @Binding var count: FlowCount
    @State private var content = ""
    @State private var fontSize: CGFloat = 0
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    @State private var rotation3D = Rotation3D()
    @State private var position: CGPoint = UIScreen.getRandomPoint()
    
    var body: some View {
        GeometryReader { geometry in
            Text(content)
                .font(.system(size: fontSize, weight: weight, design: design))
                .foregroundColor(tornado.colors.txt)
                .position(position)
                .rotation3DEffect(.degrees(rotation3D.angle),
                                  axis: (x: rotation3D.axis.x,
                                         y: rotation3D.axis.y,
                                         z: rotation3D.axis.z),
                                  anchorZ: rotation3D.anchorZ,
                                  perspective: rotation3D.perspective)
                .onAppear {
                    move(in: geometry.size)
                }
                .onChange(of: count.value) { _ in
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
    
    private func move(in size: CGSize) {
        withAnimation(.easeIn(duration: duration)) {
            position.x = CGFloat.random(in: 0...size.width)
            position.y = CGFloat.random(in: 0...size.height)
            rotation3D.random()
            rotation3D.angle += Double.random(in: tornado.angleRange.range)
            
            if rotation3D.angle > 3600 {
                rotation3D.angle -= 3600
            }
        }
    }
}
