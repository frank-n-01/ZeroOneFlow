// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct CircleHome: View {
    @ObservedObject var circle = CircleViewModel()
    
    var body: some View {
        FontView(fonts: $circle.fonts,
                 minSize: 5, maxSize: 300,
                 isRandom: true)
        
        ColorView(colors: $circle.colors, random: false)
        
        ContentTypeView(contents: $circle.contents)
        
        Section {
            SliderWithSingleImage(value: $circle.depth,
                                  min: 1, max: 300,
                                  image: "smallcircle.circle")
        } header: {
            Text("Scale")
        }
        
        Section {
            SandwichedImageSlider(interval: $circle.interval,
                                  min: 0.01, max: 1.0)
        } header: {
            Text("Speed")
        }
        
        Section {
            CGFloatSlider(value: $circle.gap,
                          min: 0.01, max: 100,
                          image: "circlebadge.2",
                          format: circle.gap < 10 ? "%.2f" : circle.gap < 100 ? "%.1f" : "%.0f")
        } header: {
            Text("Gap")
        }
        
        Section {
            SliderWithSingleImage(value: $circle.rotationAngle,
                                  min: 0, max: 360,
                                  image: "crop.rotate")
        } header: {
            Text("Rotation")
        }
    }
}
