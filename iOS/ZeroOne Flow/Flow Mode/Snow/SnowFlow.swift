// Copyright © 2022 Ni Fu. All rights reserved.

import SwiftUI

struct SnowFlow: View {
    @ObservedObject var snow: SnowViewModel
    @State private var loop = 0
    @State private var count = FlowCount()
    @State private var height: CGFloat = 0
    @State private var width: CGFloat = 0
    @State private var fallRange: ClosedRange<CGFloat> = 0...0
    @State private var windRange: ClosedRange<CGFloat> = 0...0
    @State private var appearRange: ClosedRange<CGFloat> = 0...0
    @State private var bottom: CGFloat = 0
    
    var body: some View {
        ZStack {
            snow.colors.bg.edgesIgnoringSafeArea(.all)
            
            ScreenSizeGetter(height: $height, width: $width)
            
            ForEach(0 ..< loop, id: \.self) { i in
                if i < count.value {
                    SnowFlake(snow: snow, count: $count, fallRange: $fallRange,
                              appearRange: $appearRange, bottom: $bottom, width: $width)
                }
            }
        }
        .onAppear {
            loop = Int(snow.scale)
            fallRange = -(snow.step / 3)...snow.step
            appearRange = -height...0
            bottom = height * 2
        }
        .onChange(of: height) { newHeight in
            appearRange = -newHeight...0
            bottom = newHeight * 2
        }
        .onReceive(Timer.publish(every: snow.interval, on: .current,
                                 in: .common).autoconnect()) { _ in
            guard snow.isFlowing else { return }
            count.increment()
        }
    }
}

struct SnowFlake: View {
    @ObservedObject var snow: SnowViewModel
    @Binding var count: FlowCount
    @Binding var fallRange: ClosedRange<CGFloat>
    @Binding var appearRange: ClosedRange<CGFloat>
    @Binding var bottom: CGFloat
    @Binding var width: CGFloat
    @State private var content = ""
    @State private var size: CGFloat = 0
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    @State private var position = CGPoint()
    
    var body: some View {
        Text(content)
            .font(.system(size: size, weight: weight, design: design))
            .foregroundColor(snow.colors.txt)
            .position(position)
            .onAppear {
                size = snow.fonts.sizeRange.getRandomSizeInRange()
                design = snow.fonts.design.value
                weight = snow.fonts.weight.value
                position.x = CGFloat.random(in: 0...width)
                position.y = CGFloat.random(in: appearRange)
                content = ContentMaker.make(with: snow.contents)
            }
            .onChange(of: count.value) { _ in
                withAnimation {
                    position.y += CGFloat.random(in: fallRange)
                    position.x += CGFloat.random(in: -snow.wind...snow.wind)
                }
                if position.y > bottom {
                    position.y = CGFloat.random(in: appearRange)
                    position.x = CGFloat.random(in: 0...width)
                }
            }
    }
}