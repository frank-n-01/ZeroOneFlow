// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct WormFlow: View {
    @ObservedObject var worm: WormViewModel
    @State var position: [CGPoint] = []
    @State private var loop = 0
    @State private var crawling = 0
    @State private var isToLeft = false
    @State private var isUpward = false
    @State private var width: CGFloat = 0
    @State private var height: CGFloat = 0
    
    var body: some View {
        if worm.start {
            ZStack {
                worm.colors.bg.edgesIgnoringSafeArea(.all)
                wormHead
                wormBody
            }
            .onAppear {
                loop = Int(worm.length)
                crawling = Int(worm.crawling)
                setPosition()
            }
        }
    }
    
    private var wormHead: some View {
        GeometryReader { geometry in
            Text("")
                .onReceive(Timer.publish(every: worm.start ? worm.interval : 100, on: .current, in: .common).autoconnect()) { _ in
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
        ForEach(0 ..< loop, id: \.self) { i in
            WormParts(worm: worm, position: $position[i])
        }
    }
    
    private func moveHeadX() {
        let step = CGFloat(Double.random(in: 0...Double(worm.step)))
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
        if Int.random(in: 0...crawling) == 0 {
            isToLeft.toggle()
        }
        if Int.random(in: 0...crawling) == 0 {
            isUpward.toggle()
        }
    }
    
    /// The  worm body follows the head.
    private func moveBody() {
        for i in (1 ..< loop).reversed() {
            position[i].x = position[i - 1].x
            position[i].y = position[i - 1].y
        }
    }
    
    private func setPosition() {
        let x = UIScreen.main.bounds.width / 2
        let y = UIScreen.main.bounds.height / 2
        position = Array(repeating: CGPoint(x: x, y: y), count: loop)
    }
}

struct WormParts: View {
    @ObservedObject var worm: WormViewModel
    @Binding var position: CGPoint
    @State private var content = ""
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    
    var body: some View {
        if worm.start {
            Text(content)
                .font(.system(size: worm.fonts.size, weight: weight, design: design))
                .foregroundColor(worm.colors.txt)
                .position(position)
                .animation(.linear, value: position)
                .onAppear {
                    content = ContentMaker.makeContent(with: worm.contents)
                    design = worm.fonts.design.value
                    weight = worm.fonts.weight.value
                }
        }
    }
}
