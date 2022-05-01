// Copyright © 2022 Ni Fu. All rights reserved.

import SwiftUI

struct WaveFlow: View {
    @ObservedObject var wave: WaveViewModel
    @State private var scale = 0
    @State private var count = FlowCount()
    @State private var height: CGFloat = UIScreen.main.bounds.height
    @State private var width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            wave.colors.bg.edgesIgnoringSafeArea(.all)
            ScreenSizeGetter(height: $height, width: $width)
            
            ForEach(0 ..< scale, id: \.self) { i in
                WaveLine(wave: wave, count: $count,
                         height: $height, width: $width)
            }
        }
        .onAppear {
            scale = Int(round(wave.scale))
            wave.verifyVerticalPadding(height: height)
        }
        .onChange(of: height) { newHeight in
            wave.setMaxVerticalPadding(height: newHeight)
            wave.verifyVerticalPadding(height: newHeight)
        }
        .onReceive(Timer.publish(every: wave.interval, on: .current,
                                 in: .common).autoconnect()) { _ in
            guard wave.isFlowing else { return }
            count.increment()
        }
    }
}

struct WaveLine: View {
    @ObservedObject var wave: WaveViewModel
    @Binding var count: FlowCount
    @Binding var height: CGFloat
    @Binding var width: CGFloat
    @State private var length = 0
    @State private var joint = 0
    @State private var positions: [CGPoint] = []
    
    
    var body: some View {
        ZStack {
            ForEach(0 ..< length, id: \.self) { i in
                WaveElement(wave: wave, count: $count, position: $positions[i])
            }
        }
        .onAppear {
            setPositions()
        }
        .onChange(of: width) { _ in
            setPositions()
        }
        .onChange(of: count.value) { _ in
            move()
        }
    }
    
    private func setPositions() {
        length = Int(width / wave.gap)
        joint = Int.random(in: 1 ..< length)
        
        let y = height / 2
        positions = Array(repeating: CGPoint(x: 0, y: y), count: length)
        
        for i in 0 ..< length {
            positions[i].x = wave.gap * CGFloat(i)
        }
    }
    
    private func move() {
        withAnimation {
            if positions[joint].y < wave.paddingVertical {
                positions[joint].y += Double.random(in: 0...wave.amplitude)
            } else if positions[joint].y > height - wave.paddingVertical {
                positions[joint].y -= Double.random(in: 0...wave.amplitude)
            } else {
                positions[joint].y += Double.random(in: -wave.amplitude...wave.amplitude)
            }
            
            for i in (1 ... joint).reversed() {
                positions[i - 1].y = positions[i].y + Double.random(in: -wave.amplitude...wave.amplitude)
            }
            
            for i in joint ..< length {
                positions[i].y = positions[i - 1].y + Double.random(in: -wave.amplitude...wave.amplitude)
            }
        }
        if count.value % 10 == 0 {
            joint = Int.random(in: 1 ..< length)
        }
    }
}

struct WaveElement: View {
    @ObservedObject var wave: WaveViewModel
    @Binding var count: FlowCount
    @Binding var position: CGPoint
    @State private var content = ""
    @State private var size: CGFloat = 0
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    
    var body: some View {
        Text(content)
            .font(.system(size: size, weight: weight, design: design))
            .foregroundColor(wave.colors.txt)
            .position(position)
            .onAppear {
                size = wave.fonts.sizeRange.getRandomSizeInRange()
                design = wave.fonts.design.value
                weight = wave.fonts.weight.value
                content = ContentMaker.make(with: wave.contents)
            }
    }
}
