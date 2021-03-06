// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct WormHome: View {
    @ObservedObject var worm: WormViewModel
    
    var body: some View {
        Section {
            SingleImageSlider(value: $worm.length, min: 1, max: 300,
                              image: "ruler.fill", format: "%.0f")
        } header: {
            Text("Length")
        }
        
        FontView(fonts: $worm.fonts, minSize: 5, maxSize: 300, isRandom: true)
        
        ColorView(colors: $worm.colors)
        
        ContentTypeView(contents: $worm.contents)
        
        Section {
            SandwichImageSlider(value: $worm.interval, min: 0.01, max: 1.0)
        } header: {
            Text("Speed")
        }
        
        Section {
            SingleImageSlider(value: $worm.step, min: 1, max: 300,
                              image: "arrowshape.zigzag.right.fill", format: "%.0f")
        } header: {
            Text("Step")
        }

        Section {
            SandwichImageSlider(value: $worm.crawling, min: 0, max: 200,
                                firstImage: "scribble.variable", secondImage: "arrow.forward")
        } header: {
            Text("Crawling")
        }
        
        PaddingSliderView(padding: $worm.padding)
    }
}
