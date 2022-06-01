// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct FlyFlow: View {
    @ObservedObject var fly: FlyViewModel
    @State private var scale = 0
    @State private var count = FlowCount()
    
    var body: some View {
        ZStack {
            fly.colors.bg.edgesIgnoringSafeArea(.all)
            
            ForEach(0 ..< scale, id: \.self) { i in
                if i < count.value {
                    FlyParts(fly: fly, count: $count)
                }
            }
        }
        .onAppear {
            scale = Int(round(fly.scale))
        }
        .onChange(of: fly.isFlowing) { isFlowing in
            guard isFlowing else { return }
            count.value = 0
            scale = Int(round(fly.scale))
        }
        .onReceive(Timer.publish(every: fly.isFlowing ? fly.interval : 100,
                                 on: .current, in: .common).autoconnect()) { _ in
            guard fly.isFlowing else { return }
            count.increment()
        }
    }
}

private struct FlyParts: View {
    @ObservedObject var fly: FlyViewModel
    @Binding var count: FlowCount
    @State private var content = ""
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    @State private var position: CGPoint = UIScreen.getRandomPoint()
    
    var body: some View {
        GeometryReader { geometry in
            Text(content)
                .font(.system(size: fly.fonts.size,
                              weight: weight,
                              design: design))
                .foregroundColor(fly.colors.txt)
                .position(position)
                .onChange(of: count.value) { _ in
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
            position.x = CGFloat.random(
                in: fly.padding.horizontal...(geometry.size.width - fly.padding.horizontal))
            
            position.y = CGFloat.random(
                in: fly.padding.vertical...(geometry.size.height - fly.padding.vertical))
        }
    }
}
