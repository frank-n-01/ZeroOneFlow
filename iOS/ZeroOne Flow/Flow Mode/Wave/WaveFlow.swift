// Copyright © 2022 Ni Fu. All rights reserved.

import SwiftUI

struct WaveFlow: View {
    @ObservedObject var wave: WaveViewModel
    @State private var scale = 0
    @State private var count = FlowCount()
    
    var body: some View {
        ZStack {
            wave.colors.bg.edgesIgnoringSafeArea(.all)
            
            ForEach(0 ..< scale, id: \.self) { i in
                if i < count.value {
                    WaveLine(wave: wave, count: $count)
                }
            }
        }
        .onAppear {
            scale = Int(wave.scale)
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
    @State private var length = 0
    @State private var centerIndex = 0
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
        .onChange(of: UIScreen.main.bounds.width) { _ in
            setPositions()
        }
        .onChange(of: count.value) { _ in
            move()
        }
    }
    
    private func setPositions() {
        length = Int(UIScreen.main.bounds.width / wave.gap)
        centerIndex = length / 2
        
        let y = UIScreen.main.bounds.height / 2
        for i in 0 ..< length {
            positions.append(CGPoint(x: wave.gap * CGFloat(i), y: y))
        }
    }
    
    private func move() {
        withAnimation {
            positions[centerIndex].y += Double.random(in: -wave.amplitude...wave.amplitude)
            
            for i in (1 ... centerIndex).reversed() {
                positions[i - 1].y = positions[i].y + Double.random(in: -wave.amplitude...wave.amplitude)
            }
            
            guard centerIndex < length else { return }
            
            for i in centerIndex ..< length {
                positions[i].y = positions[i - 1].y + Double.random(in: -wave.amplitude...wave.amplitude)
            }
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
