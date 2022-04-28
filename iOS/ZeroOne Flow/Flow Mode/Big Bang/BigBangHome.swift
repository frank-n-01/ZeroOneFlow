// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct BigBangHome: View {
    @ObservedObject var bigbang: BigBangViewModel

    var body: some View {
        Section {
            SingleImageSlider(value: $bigbang.scale, min: 1, max: 500,
                              image: "hurricane", format: "%.0f")
        } header: {
            Text("Scale")
        }
        
        FontRangeView(fonts: $bigbang.fonts, min: 5, max: 200, isRandom: true)
        
        ColorView(colors: $bigbang.colors)
        
        ContentTypeView(contents: $bigbang.contents)
        
        Section {
            SandwichImageSlider(interval: $bigbang.interval, min: 0.01, max: 0.2)
        } header: {
            Text("Speed")
        }
        
        Section {
            CGFloatSlider(value: $bigbang.gap, min: 0.01, max: 200,
                          image: "arrow.up.left.and.arrow.down.right",
                          format: gapSliderNumberFormat)
        } header: {
            Text("Stretch")
        }
        
        Section {
            SingleImageSlider(value: $bigbang.rotationAngle, min: 0, max: 360,
                              image: "crop.rotate", format: "%.0f")
            ToggleWithLabel(value: $bigbang.is3D, label: "3D",
                            trueImage: "move.3d", falseImage: "move.3d")
        } header: {
            Text("Rotation")
        }
        
        PaddingView(padding: $bigbang.padding)
    }
    
    private var gapSliderNumberFormat: String {
        if bigbang.gap < 10 {
            return "%.2f"
        } else if bigbang.gap < 100 {
            return "%.1f"
        } else {
            return "%.0f"
        }
    }
}
