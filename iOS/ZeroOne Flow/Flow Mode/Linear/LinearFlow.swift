// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct LinearFlow: View {
    @ObservedObject var linear: LinearViewModel
    @State private var flow = LinearFlowParameters()

    var body: some View {
        ZStack {
            linear.colors.bg.edgesIgnoringSafeArea(.all)
            ScreenSizeGetter(height: $flow.screenHeight, width: $flow.screenWidth)
            
            GeometryReader { _ in
                Text(flow.content)
                    .font(.system(size: linear.fonts.size,
                                  weight: linear.fonts.weight.value,
                                  design: linear.fonts.design.value))
                    .foregroundColor(linear.colors.txt)
                    .kerning(flow.kerning)
                    .lineSpacing(flow.lineSpacing)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: flow.screenWidth, alignment: .topLeading)
                    .background(currentHeightGetter)
            }
        }
        .onReceive(Timer.publish(every: linear.interval, on: .current,
                                 in: .common).autoconnect()) { _ in
            guard linear.isFlowing else { return }
            move()
        }
        .onAppear {
            flow.isRepeat = linear.isRepeat
            flow.adjustKerning(contents: linear.contents)
            flow.adjustLineSpacing(contents: linear.contents)
            CodeMaker.reset()
        }
    }
    
    private var currentHeightGetter: some View {
        GeometryReader { geometry in
            Text("")
                .onAppear {
                    flow.currentHeight = geometry.size.height
                }
                .onChange(of: geometry.size.height) { _ in
                    flow.currentHeight = geometry.size.height
                    flow.controlRepeat()
                }
        }
    }
    
    private func move() {
        guard flow.currentHeight <= flow.screenHeight else {
            flow.controlRepeat()
            return
        }
        
        if !linear.isRepeat {
            flow.preservedContent = flow.content
        }
        
        flow.content += ContentMaker.make(with: linear.contents)
        flow.content += ContentMaker
            .getRandomLineFeed(linear.linefeed, linear.indents, linear.contents)
    }
}

private struct LinearFlowParameters {
    var content = ""
    var preservedContent = ""
    var screenHeight: CGFloat = 0.0
    var screenWidth: CGFloat = 0.0
    var currentHeight: CGFloat = 0.0
    var lineSpacing: CGFloat = 0.0
    var kerning: CGFloat = 0.0
    var isStopped = false
    var isRepeat: Bool = true
    
    mutating func controlRepeat() {
        if isRepeat {
            if currentHeight > screenHeight {
                content = ""
                ContentMaker.reset()
            }
        } else if currentHeight > screenHeight {
            isStopped = true
            content = preservedContent
            preservedContent = ""
        }
    }
    
    mutating func adjustKerning(contents: Contents) {
        switch contents.type {
        case .language:
            switch contents.language {
            case .greek:
                kerning = 3.0
            case .hieroglyph:
                kerning = 5.0
            case .arabic:
                kerning = 0.0
            default:
                kerning = 1.0
            }
        case .symbol:
            switch contents.symbol {
            case .currency:
                kerning = 3.0
            default:
                kerning = 0.0
            }
        default:
            kerning = 0.0
        }
    }
    
    mutating func adjustLineSpacing(contents: Contents) {
        switch contents.type {
        case .language:
            switch contents.language {
            case .cuneiform, .hieroglyph:
                lineSpacing = 10.0
            case .greek:
                lineSpacing = 0.0
            default:
                lineSpacing = 5.0
            }
        case .symbol:
            switch contents.symbol {
            case .currency:
                lineSpacing = 1.0
            default:
                lineSpacing = 0.0
            }
        default:
            lineSpacing = 0.0
        }
    }
}
