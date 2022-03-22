// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct BigBangHome: View {
    @ObservedObject var bigbang = BigBangViewModel()

    var body: some View {
        FontRangeView(fonts: $bigbang.fonts,
                      min: 5, max: 200,
                      isRandom: true)
        
        ColorView(colors: $bigbang.colors)
        
        ContentTypeView(contents: $bigbang.contents)
        
        Section {
            SliderWithSingleImage(value: $bigbang.scale,
                                  min: 1, max: 500,
                                  image: "hurricane", format: "%.0f")
        } header: {
            Text("Scale")
        }
        
        Section {
            SpeedSlider(interval: $bigbang.interval,
                                  min: 0.01, max: 0.2)
        } header: {
            Text("Speed")
        }
        
        Section {
            CGFloatSlider(value: $bigbang.gap,
                          min: 0.01, max: 200,
                          image: "arrow.up.left.and.arrow.down.right",
                          format: bigbang.gap < 10 ? "%.2f" : bigbang.gap < 100 ? "%.1f" : "%.0f")
        } header: {
            Text("Stretch")
        }
        
        Section {
            SliderWithSingleImage(value: $bigbang.rotationAngle,
                                  min: 0, max: 360,
                                  image: "crop.rotate", format: "%.0f")
            ToggleWithLabel(value: $bigbang.is3D,
                            label: "3D",
                            trueImage: "move.3d", falseImage: "move.3d")
        } header: {
            Text("Rotation")
        }
        
        PaddingView(padding: $bigbang.padding)
    }
}
