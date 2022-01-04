// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct RainHome: View {
    @ObservedObject var rain = RainViewModel()
    
    var body: some View {
        FontRangeView(fonts: $rain.fonts, min: 5, max: 500, isRandom: true)
        
        ColorView(colors: $rain.colors, random: false)
        
        ContentTypeView(contents: $rain.contents)
        
        Section {
            SliderWithSingleImage(value: $rain.scale, min: 1, max: 300, image: "cloud.rain.fill", format: "%.0f")
        } header: {
            Text("Scale")
        }
        
        Section {
            SliderWithSingleImage(value: $rain.length, min: 1, max: 500, image: "ruler.fill", format: "%.0f")
        } header: {
            Text("Length")
        }
        
        Section {
            SandwichedImageSlider(interval: $rain.interval, min: 0.01, max: 0.5)
        } header: {
            Text("Speed")
        }
        
        Section {
            SliderWithSingleImage(value: $rain.step, min: 1, max: 9999, image: "arrowshape.zigzag.right.fill", format: "%.0f")
        } header: {
            Text("Step")
        }
    }
}
