// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct SingleFlow: View {
    @ObservedObject var single: SingleViewModel
    @State private var content = ""
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    @State private var txtColor = Color("Text")
    @State private var gradient = RandomGradient()
    
    var body: some View {
        ZStack {
            BackgroundGradientView(colors: $single.colors, gradient: $gradient)
            
            GeometryReader { geometry in
                Text(content)
                    .font(.system(size: single.fonts.size,
                                  weight: weight,
                                  design: design))
                    .foregroundColor(txtColor)
                    .position(x: geometry.size.width / 2,
                              y: geometry.size.height / 2)
                    .fixedSize()
                    .onAppear {
                        content = ContentMaker.make(with: single.contents)
                        design = single.fonts.design.value
                        weight = single.fonts.weight.value
                        txtColor = single.colors.txt
                        gradient.type = single.gradientType
                    }
            }
        }
        .onReceive(Timer.publish(every: single.isFlowing ? single.interval : 100,
                                 on: .current, in: .common).autoconnect()) { _ in
            guard single.isFlowing else { return }
            
            content = ContentMaker.make(with: single.contents)
            design = single.fonts.design.value
            weight = single.fonts.weight.value
            
            withAnimation(.easeIn) {
                randomColor()
            }
        }
    }
    
    /// Make random colors if the random color mode is activated.
    private func randomColor() {
        if single.colors.bgRandom {
            txtColor = Colors.getRandom()
            gradient.random()
        }
    }
}
