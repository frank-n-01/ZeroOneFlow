// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct SingleFlow: View {
    @ObservedObject var single: SingleViewModel
    @State private var content = ""
    @State private var design: Font.Design = .monospaced
    @State private var weight: Font.Weight = .regular
    @State private var txtColor = CommonStyle.TEXT_COLOR
    @State private var gradient = RandomGradient()
    @State private var position = CGPoint()
    
    var body: some View {
        ZStack {
            BackgroundGradientView(colors: $single.colors, gradient: $gradient)
            
            GeometryReader { geometry in
                Text(content)
                    .font(.system(size: single.fonts.size,
                                  weight: weight,
                                  design: design))
                    .foregroundColor(txtColor)
                    .position(position)
                    .fixedSize()
                    .onAppear {
                        position.x = geometry.size.width / 2
                        position.y = geometry.size.height / 2
                        content = ContentMaker.make(with: single.contents)
                        design = single.fonts.design.value
                        weight = single.fonts.weight.value
                        txtColor = single.colors.txt
                        gradient.type = single.gradientType
                    }
                    .onChange(of: geometry.size) { newSize in
                        position.x = newSize.width / 2
                        position.y = newSize.height / 2
                    }
            }
        }
        .onReceive(Timer.publish(every: single.interval, on: .current,
                                 in: .common).autoconnect()) { _ in
            guard single.isFlowing else { return }
            
            content = ContentMaker.make(with: single.contents)
            design = single.fonts.design.value
            weight = single.fonts.weight.value
            
            if single.colors.bgRandom {
                withAnimation(.easeIn) {
                    txtColor = Colors.random()
                    gradient.random()
                }
            }
        }
    }
}
