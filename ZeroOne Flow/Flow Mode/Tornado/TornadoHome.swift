// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct TornadoHome: View {
    @ObservedObject var tornado: TornadoViewModel
    
    var body: some View {
        Section {
            SliderWithSingleImage(value: $tornado.scale,
                                  min: 1, max: 300, image: "tornado")
        } header: {
            Text("Scale")
        }
        
        FontRangeView(fonts: $tornado.fonts, min: 5, max: 300, isRandom: true)
        
        ColorView(colors: $tornado.colors)
        
        ContentTypeView(contents: $tornado.contents)
        
        Section {
            RangeSliders(range: $tornado.durationRange, min: 0.01, max: 10.0)
        } header: {
            Text("Duration")
        }
        
        Section {
            RangeSliders(range: $tornado.angleRange, min: 0, max: 360)
        } header: {
            Text("Rotation")
        }
    }
}
