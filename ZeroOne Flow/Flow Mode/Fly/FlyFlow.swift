// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct FlyFlow: View {
    @ObservedObject var fly: FlyViewModel
    @State private var count = 0
    @State private var loop = 0
    
    var body: some View {
        ZStack {
            fly.colors.bg.edgesIgnoringSafeArea(.all)
            
            ForEach(0 ..< loop, id: \.self) { i in
                if i < count {
                    FlyParts(fly: fly, count: $count)
                }
            }
        }
        .onAppear {
            loop = Int(fly.scale)
        }
        .onReceive(Timer.publish(every: fly.isFlowing ? fly.interval : 100, on: .current, in: .common).autoconnect()) { _ in
            count += 1
            // Avoid over flow.
            if count > 100000 {
                count = 1000
            }
        }
    }
}

private struct FlyParts: View {
    @ObservedObject var fly: FlyViewModel
    @Binding var count: Int
    @State private var content = ""
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    @State private var position: CGPoint = UIScreen.getRandomPoint()
    
    var body: some View {
        GeometryReader { geometry in
            Text(content)
                .font(.system(size: fly.fonts.size, weight: weight, design: design))
                .foregroundColor(fly.colors.txt)
                .position(position)
                .onChange(of: count) { _ in
                    move(geometry)
                }
                .onAppear {
                    move(geometry)
                }
        }
        .onAppear {
            content = ContentMaker.make(with: fly.contents)
            design = fly.fonts.design.value
            weight = fly.fonts.weight.value
        }
    }
    
    private func move(_ geometry: GeometryProxy) {
        withAnimation(.easeIn) {
            position.x = CGFloat.random(in: fly.padding.hor...(geometry.size.width - fly.padding.hor))
            position.y = CGFloat.random(in: fly.padding.ver...(geometry.size.height - fly.padding.ver))
        }
    }
}
