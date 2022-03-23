// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct FlyFlow: View {
    @ObservedObject var fly: FlyViewModel
    @State private var loop = 0
    @State private var count = FlowCount()
    
    var body: some View {
        ZStack {
            fly.colors.bg.edgesIgnoringSafeArea(.all)
            
            ForEach(0 ..< loop, id: \.self) { i in
                if i < count.value {
                    FlyParts(fly: fly, count: $count)
                }
            }
        }
        .onAppear {
            loop = Int(fly.scale)
        }
        .onReceive(Timer.publish(every: fly.isFlowing ? fly.interval : 100,
                                 on: .current, in: .common).autoconnect()) { _ in
            count.increment()
        }
    }
}

private struct FlyParts: View {
    @ObservedObject var fly: FlyViewModel
    @Binding var count: FlowCount
    @State private var flow = FlyFlowParameters()
    
    var body: some View {
        GeometryReader { geometry in
            Text(flow.content)
                .font(.system(size: fly.fonts.size,
                              weight: flow.weight,
                              design: flow.design))
                .foregroundColor(fly.colors.txt)
                .position(flow.position)
                .onChange(of: count.value) { _ in
                    move(geometry)
                }
                .onAppear {
                    move(geometry)
                }
        }
        .onAppear {
            flow.content = ContentMaker.make(with: fly.contents)
            flow.design = fly.fonts.design.value
            flow.weight = fly.fonts.weight.value
        }
    }
    
    private func move(_ geometry: GeometryProxy) {
        withAnimation(.easeIn) {
            flow.position.x = CGFloat.random(
                in: fly.padding.hor...(geometry.size.width - fly.padding.hor))
            
            flow.position.y = CGFloat.random(
                in: fly.padding.ver...(geometry.size.height - fly.padding.ver))
        }
    }
}

private struct FlyFlowParameters {
    var content = ""
    var design: Font.Design = .monospaced
    var weight: Font.Weight = .regular
    var position: CGPoint = UIScreen.getRandomPoint()
}
