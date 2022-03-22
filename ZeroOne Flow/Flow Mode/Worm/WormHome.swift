// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct WormHome: View {
    @ObservedObject var worm = WormViewModel()
    
    var body: some View {
        FontView(fonts: $worm.fonts,
                 minSize: 5, maxSize: 300,
                 isRandom: true)
        
        ColorView(colors: $worm.colors)
        
        ContentTypeView(contents: $worm.contents)
        
        Section {
            SliderWithSingleImage(value: $worm.length,
                                  min: 1, max: 300,
                                  image: "ruler.fill", format: "%.0f")
        } header: {
            Text("Length")
        }
        
        Section {
            SpeedSlider(interval: $worm.interval,
                                  min: 0.01, max: 1.0)
        } header: {
            Text("Speed")
        }
        
        Section {
            SliderWithSingleImage(value: $worm.step,
                                  min: 1, max: 300,
                                  image: "arrowshape.zigzag.right.fill",
                                  format: "%.0f")
        } header: {
            Text("Step")
        }

        Section {
            SliderWithSingleImage(value: $worm.crawling,
                                  min: 0, max: 200,
                                  image: "scribble.variable", format: "%.0f")
        } header: {
            Text("Crawling")
        }
        
        PaddingView(padding: $worm.padding)
    }
}
