// Copyright © 2022 Ni Fu. All rights reserved.

import SwiftUI

struct WaveHome: View {
    @ObservedObject var wave: WaveViewModel
    
    var body: some View {
        Section {
            SingleImageSlider(value: $wave.scale, min: 1, max: 10,
                              image: "waveform.circle", format: "%.0f")
        } header: {
            Text("Scale")
        }
        
        FontRangeView(fonts: $wave.fonts, min: 5, max: 500, isRandom: true)
        
        ColorView(colors: $wave.colors)
        
        ContentTypeView(contents: $wave.contents)
        
        Section {
            SandwichImageSlider(value: $wave.interval, min: 0.01, max: 0.5)
        } header: {
            Text("Speed")
        }
        
        Section {
            SingleImageSlider(value: $wave.gap, min: 1, max: 50,
                              image: "circlebadge.2", format: "%.0f")
        } header: {
            Text("Gap")
        }
        
        Section {
            SingleImageSlider(value: $wave.amplitude, min: 1, max: 500,
                              image: "waveform.path.ecg", format: "%.0f")
        } header: {
            Text("Amplitude")
        }
        
        Section {
            SingleImageSlider(value: $wave.paddingVertical, min: 0,
                              max: WaveViewModel.maxVerticalPadding,
                              image: "arrow.up.and.down", format: "%.0f")
        } header: {
            Text("Padding")
        }
    }
}
