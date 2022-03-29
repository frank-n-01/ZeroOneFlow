// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct CircleHome: View {
    @ObservedObject var circle: CircleViewModel
    
    var body: some View {
        Section {
            SingleImageSlider(value: $circle.depth,
                              min: 1, max: 300, image: "smallcircle.circle")
        } header: {
            Text("Scale")
        }
        
        FontView(fonts: $circle.fonts, minSize: 5, maxSize: 300, isRandom: true)
        
        ColorView(colors: $circle.colors)
        
        ContentTypeView(contents: $circle.contents)
        
        Section {
            SpeedSlider(interval: $circle.interval, min: 0.01, max: 1.0)
        } header: {
            Text("Speed")
        }
        
        Section {
            CGFloatSlider(value: $circle.gap, min: 0.01, max: 100,
                          image: "circlebadge.2", format: gapSliderNumberFormat)
        } header: {
            Text("Gap")
        }
        
        Section {
            SingleImageSlider(value: $circle.rotationAngle,
                              min: 0, max: 360, image: "crop.rotate")
        } header: {
            Text("Rotation")
        }
    }
    
    private var gapSliderNumberFormat: String {
        if circle.gap < 10 {
            return "%.2f"
        } else if circle.gap < 100 {
            return "%.1f"
        } else {
            return "%.0f"
        }
    }
}
