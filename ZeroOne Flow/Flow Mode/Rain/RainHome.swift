// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct RainHome: View {
    @ObservedObject var rain: RainViewModel
    
    var body: some View {
        FontRangeView(fonts: $rain.fonts, min: 5, max: 500, isRandom: true)
        
        ColorView(colors: $rain.colors)
        
        ContentTypeView(contents: $rain.contents)
        
        Section {
            SingleImageSlider(value: $rain.scale, min: 1, max: 300,
                              image: "cloud.rain.fill", format: "%.0f")
        } header: {
            Text("Scale")
        }
        
        Section {
            SingleImageSlider(value: $rain.length, min: 1, max: 300,
                              image: "ruler.fill", format: "%.0f")
        } header: {
            Text("Length")
        }
        
        Section {
            SpeedSlider(interval: $rain.interval, min: 0.01, max: 0.5)
        } header: {
            Text("Speed")
        }
        
        Section {
            SingleImageSlider(value: $rain.step, min: 1, max: 300,
                              image: "arrowshape.zigzag.right.fill", format: "%.0f")
        } header: {
            Text("Step")
        }
    }
}
