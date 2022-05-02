// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct RainFlow: View {
    @ObservedObject var rain: RainViewModel
    @State private var scale = 0
    @State private var count = FlowCount()
    @State private var height: CGFloat = 0
    @State private var width: CGFloat = 0
    
    var body: some View {
        ZStack {
            rain.colors.bg.edgesIgnoringSafeArea(.all)
            ScreenSizeGetter(height: $height, width: $width)
            
            ForEach(0 ..< scale, id: \.self) { i in
                if i < count.value {
                    RainDrop(rain: rain, count: $count, height: $height, width: $width)
                }
            }
        }
        .onAppear {
            scale = Int(round(rain.scale))
        }
        .onReceive(Timer.publish(every: rain.interval, on: .current,
                                 in: .common).autoconnect()) { _ in
            guard rain.isFlowing else { return }
            count.increment()
        }
    }
}

struct RainDrop: View {
    @ObservedObject var rain: RainViewModel
    @Binding var count: FlowCount
    @Binding var height: CGFloat
    @Binding var width: CGFloat
    @State private var content = ""
    @State private var length = 0
    @State private var position = CGPoint()
    @State private var size: CGFloat = 0
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    
    var body: some View {
        Text(content)
            .font(.system(size: size, weight: weight, design: design))
            .foregroundColor(rain.colors.txt)
            .position(position)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .onAppear {
                size = rain.fonts.sizeRange.getRandomSizeInRange()
                design = rain.fonts.design.value
                weight = rain.fonts.weight.value
                position.x = CGFloat.random(in: 0...width)
                position.y = CGFloat.random(in: -height...0)
                length = Int.random(in: 1...Int(rain.length))
                makeContent()
            }
            .onChange(of: count.value) { _ in
                move()
            }
    }
    
    private func makeContent() {
        DispatchQueue.global().async {
            var rainString = ""
            for _ in 0 ..< length {
                rainString += ContentMaker.make(with: rain.contents) + "\n"
            }
            DispatchQueue.main.async {
                content = rainString
            }
        }
    }
    
    private func move() {
        withAnimation() {
            position.y += CGFloat.random(in: 1...rain.step)
        }
        if position.y > height {
            position.y = CGFloat.random(in: -height...0)
            position.x = CGFloat.random(in: 0...width)
        }
    }
}
