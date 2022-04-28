// Copyright © 2022 Ni Fu. All rights reserved.

import SwiftUI

struct SnowHome: View {
    @ObservedObject var snow: SnowViewModel
    
    var body: some View {
        Section {
            SingleImageSlider(value: $snow.scale, min: 1, max: 300,
                              image: "snow", format: "%.0f")
        } header: {
            Text("Scale")
        }
        
        FontRangeView(fonts: $snow.fonts, min: 5, max: 500, isRandom: true)
        
        ColorView(colors: $snow.colors)
        
        ContentTypeView(contents: $snow.contents)
        
        Section {
            SandwichImageSlider(interval: $snow.interval, min: 0.02, max: 0.5)
        } header: {
            Text("Speed")
        }
        
        Section {
            SingleImageSlider(value: $snow.wind, min: 1, max: 500,
                              image: "wind.snow", format: "%.0f")
            SandwichImageSlider(interval: $snow.floating, min: -snow.step, max: snow.step,
                                firstImage: "arrow.counterclockwise", secondImage: "arrow.down")
        } header: {
            Text("Wind")
        }
        
        Section {
            SingleImageSlider(value: $snow.step, min: 1, max: 500,
                              image: "cloud.snow.fill", format: "%.0f")
        } header: {
            Text("Step")
        }
    }
}
