// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct RainFlow: View {
    @ObservedObject var rain: RainViewModel
    @State private var loop = 0
    @State private var count = FlowCount()
    @State private var height: CGFloat = 0
    @State private var width: CGFloat = 0
    
    var body: some View {
        ZStack {
            rain.colors.bg.edgesIgnoringSafeArea(.all)
            screenSizeGetter
            rainDrops
        }
        .onAppear {
            loop = Int(rain.scale)
        }
        .onReceive(Timer.publish(every: rain.isFlowing ? rain.interval : 100,
                                 on: .current, in: .common).autoconnect()) { _ in
            count.increment()
        }
    }
    
    private var rainDrops: some View {
        ForEach(0 ..< loop, id: \.self) { i in
            if i < count.value {
                RainDrop(rain: rain, height: $height, width: $width, count: $count)
            }
        }
    }
    
    private var screenSizeGetter: some View {
        GeometryReader { geometry in
            Text("")
                .onAppear {
                    height = geometry.size.height
                    width = geometry.size.width
                }
                .onChange(of: geometry.size) { _ in
                    height = geometry.size.height
                    width = geometry.size.width
                }
        }
    }
}

struct RainDrop: View {
    @ObservedObject var rain: RainViewModel
    @Binding var height: CGFloat
    @Binding var width: CGFloat
    @Binding var count: FlowCount
    @State private var content = ""
    @State private var length = 0
    @State private var fontSize: CGFloat = 0
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    @State private var position = CGPoint()
    @State private var isFalling = true
    @State private var top: CGFloat = 0
    @State private var bottom: CGFloat = 0
    
    var body: some View {
        Text(content)
            .font(.system(size: fontSize,
                          weight: weight,
                          design: design))
            .foregroundColor(rain.colors.txt)
            .position(position)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .background(contentSizeGetter)
            .onAppear {
                fontSize = rain.fonts.sizeRange.getRandomSizeInRange()
                design = rain.fonts.design.value
                weight = rain.fonts.weight.value
                position.x = CGFloat.random(in: 0...width)
                position.y = CGFloat.random(in: 0...height)
                length = Int.random(in: 1...Int(rain.length))
                makeContent()
            }
            .onChange(of: count.value) { _ in
                move()
            }
    }
    
    private var contentSizeGetter: some View {
        GeometryReader { geometry in
            Text("")
                .onAppear {
                    top = -(height / 2)
                    bottom = height + geometry.size.height
                }
                .onChange(of: geometry.size.height) { _ in
                    top = -(height / 2)
                    bottom = height + geometry.size.height
                }
        }
    }
    
    private func makeContent() {
        DispatchQueue.global().async {
            var rainString = ""
            for _ in 0..<length {
                rainString += ContentMaker.make(with: rain.contents) + "\n"
            }
            DispatchQueue.main.async {
                content = rainString
            }
        }
    }
    
    private func move() {
        if isFalling {
            withAnimation(.linear) {
                position.y += CGFloat.random(in: 1...rain.step)
            }
            if position.y > bottom {
                isFalling.toggle()
                position.x = CGFloat.random(in: 0...width)
            }
        } else {
            withAnimation(.linear) {
                position.y -= CGFloat.random(in: 1...rain.step)
            }
            if position.y < top {
                isFalling.toggle()
                position.x = CGFloat.random(in: 0...width)
            }
        }
    }
}
