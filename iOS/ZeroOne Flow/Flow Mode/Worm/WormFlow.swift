// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct WormFlow: View {
    @ObservedObject var worm: WormViewModel
    @State var position: [CGPoint] = []
    @State private var length = 0
    @State private var crawling = 0
    @State private var isToLeft = Bool.random()
    @State private var isUpward = Bool.random()
    @State private var width: CGFloat = 0
    @State private var height: CGFloat = 0
    
    var body: some View {
        ZStack {
            worm.colors.bg.edgesIgnoringSafeArea(.all)
            wormHead
            wormBody
        }
        .onAppear {
            length = Int(round(worm.length))
            crawling = Int(round(worm.crawling))
            position = Array(repeating: UIScreen.centerPoint, count: length)
        }
    }
    
    private var wormHead: some View {
        GeometryReader { geometry in
            Text("")
                .onReceive(Timer.publish(every: worm.interval, on: .current,
                                         in: .common).autoconnect()) { _ in
                    guard worm.isFlowing else { return }
                    moveHeadX()
                    moveHeadY()
                    turn()
                    moveBody()
                }
                .onAppear {
                    width = geometry.size.width - worm.padding.hor
                    height = geometry.size.height - worm.padding.ver
                }
                .onChange(of: geometry.size) { _ in
                    width = geometry.size.width - worm.padding.hor
                    height = geometry.size.height - worm.padding.ver
                }
        }
    }
    
    private var wormBody: some View {
        ForEach(0 ..< length, id: \.self) { i in
            WormParts(worm: worm, position: $position[i])
        }
    }
    
    private func moveHeadX() {
        let step = CGFloat(
            Double.random(in: 0...Double(worm.step))
        )
        if isToLeft {
            if position[0].x > worm.padding.hor {
                position[0].x -= step
            } else {
                isToLeft.toggle()
            }
        } else {
            if position[0].x < width {
                position[0].x += step
            } else {
                isToLeft.toggle()
            }
        }
    }
    
    private func moveHeadY() {
        let step = CGFloat(Double.random(in: 0...Double(worm.step)))
        if isUpward {
            if position[0].y > worm.padding.ver {
                position[0].y -= step
            } else {
                isUpward.toggle()
            }
        } else {
            if position[0].y < height {
                position[0].y += step
            } else {
                isUpward.toggle()
            }
        }
    }
    
    /// Change the head direction randomly.
    private func turn() {
        if Int.random(in: 0...crawling) == 0 { isToLeft.toggle() }
        if Int.random(in: 0...crawling) == 0 { isUpward.toggle() }
    }
    
    /// The body follows the head.
    private func moveBody() {
        for i in (1 ..< length).reversed() {
            position[i].x = position[i - 1].x
            position[i].y = position[i - 1].y
        }
    }
}

struct WormParts: View {
    @ObservedObject var worm: WormViewModel
    @Binding var position: CGPoint
    @State private var content = ""
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    
    var body: some View {
        Text(content)
            .font(.system(size: worm.fonts.size, weight: weight, design: design))
            .foregroundColor(worm.colors.txt)
            .position(position)
            .animation(.linear, value: position)
            .onAppear {
                content = ContentMaker.make(with: worm.contents)
                design = worm.fonts.design.value
                weight = worm.fonts.weight.value
            }
    }
}
