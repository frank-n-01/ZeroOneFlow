// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

/// Run the flow of Linear mode.
struct LinearFlow: View {
    @ObservedObject var linear: LinearViewModel
    @State private var content = ""
    @State private var screenHeight: CGFloat = 0.0
    @State private var screenWidth: CGFloat = 0.0
    @State private var currentHeight: CGFloat = 0.0
    @State private var lineSpacing: CGFloat = 0.0
    @State private var kerning: CGFloat = 0.0
    @State private var isStopped = false
    @State private var preservedContent = ""

    var body: some View {
        ZStack {
            linear.colors.bg.edgesIgnoringSafeArea(.all)
            screenSizeGetter
            GeometryReader { _ in
                Text(content)
                    .font(.system(size: linear.fonts.size, weight: linear.fonts.weight.value, design: linear.fonts.design.value))
                    .foregroundColor(linear.colors.txt)
                    .kerning(kerning)
                    .lineSpacing(lineSpacing)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: screenWidth, alignment: .topLeading)
                    .background(currentHeightGetter)
            }
        }
        .onReceive(Timer.publish(every: !isStopped ? linear.interval : 100, on: .current, in: .common).autoconnect()) { _ in
            move()
        }
        .onAppear {
            adjustKerning()
            adjustLineSpacing()
        }
    }
    
    /// Get the current screen size.
    private var screenSizeGetter: some View {
        GeometryReader { geometry in
            Text("")
                .onAppear {
                    screenHeight = geometry.size.height
                    screenWidth = geometry.size.width
                }
                .onChange(of: geometry.size) { _ in
                    screenHeight = geometry.size.height
                    screenWidth = geometry.size.width
                }
        }
    }
    
    /// Get the current height of the view from its background.
    private var currentHeightGetter: some View {
        GeometryReader { geometry in
            Text("")
                .onAppear {
                    currentHeight = geometry.size.height
                }
                .onChange(of: geometry.size.height) { _ in
                    currentHeight = geometry.size.height
                    controlFlowRepeat()
                }
        }
    }
    
    /// Control the repeat of the flow.
    private func controlFlowRepeat() {
        if linear.repeatFlow {
            // If the flow has filled the screen, it will be cleared and repeated.
            if currentHeight > screenHeight {
                content = ""
            }
        } else if currentHeight > screenHeight {
            isStopped = true
            content = preservedContent
        }
    }
    
    /// Move the flow by adding contents to the view.
    func move() {
        // If the flow has already filled the screen, add no more content.
        guard currentHeight <= screenHeight else {
            controlFlowRepeat()
            return
        }
        // If don't repeat the flow, preserve the current content.
        if !linear.repeatFlow {
            preservedContent = content
        }
        content += ContentMaker.make(with: linear.contents)
        content += ContentMaker.getRandomLineFeed(linefeed: linear.linefeed)
    }
    
    /// Adjust the kerning depend on the flow content.
    private func adjustKerning() {
        
        switch linear.contents.type {
        case .language:
            switch linear.contents.language {
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
            switch linear.contents.symbol {
            case .currency:
                kerning = 3.0
            default:
                kerning = 0.0
            }
        default:
            kerning = 0.0
        }
    }
    
    /// Adjust the line spacing depend on the flow content.
    private func adjustLineSpacing() {
        
        switch linear.contents.type {
        case .language:
            switch linear.contents.language {
            case .cuneiform, .hieroglyph:
                lineSpacing = 15.0
            case .greek:
                lineSpacing = 0.0
            default:
                lineSpacing = 5.0
            }
        case .symbol:
            switch linear.contents.symbol {
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
