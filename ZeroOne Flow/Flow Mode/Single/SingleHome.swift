// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct SingleHome: View {
    @ObservedObject var single: SingleViewModel
    
    var body: some View {
        FontView(fonts: $single.fonts, minSize: 10, maxSize: single.MAX_FONT_SIZE, isRandom: true)
        
        ColorView(colors: $single.colors, random: true)
        
        ContentTypeView(contentType: $single.contents)
        
        Section {
            SandwichedImageSlider(interval: $single.interval, min: 0.001, max: 2.0)
        } header: {
            Text("Speed")
        }
        
        Section {
            RandomGradientView(colors: $single.colors, gradientType: $single.gradientType)
        } header: {
            Text("Gradation")
        }
    }
}
