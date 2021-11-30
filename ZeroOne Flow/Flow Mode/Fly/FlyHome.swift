// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct FlyHome: View {
    @ObservedObject var fly = FlyViewModel()

    var body: some View {
        Section {
            SliderWithSingleImage(value: $fly.scale, min: 1, max: 500, image: "ladybug.fill")
        } header: {
            Text("Scale")
        }
        
        FontView(fonts: $fly.fonts, minSize: 5, maxSize: 500, isRandom: true)
        
        ColorView(colors: $fly.colors, random: false)
        
        ContentTypeView(contentType: $fly.contents)
        
        Section {
            SandwichedImageSlider(interval: $fly.interval, min: 0.01, max: 1.0)
        } header: {
            Text("Speed")
        }
        
        PaddingView(padding: $fly.padding)
    }
}

