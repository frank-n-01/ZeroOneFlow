// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct SingleHome: View {
    @ObservedObject var single: SingleViewModel
    
    var body: some View {
        FontView(fonts: $single.fonts,
                 minSize: 10, maxSize: SingleViewModel.MAX_FONT_SIZE,
                 isRandom: true)
        
        ColorView(colors: $single.colors, random: true)
        
        ContentTypeView(contents: $single.contents)
        
        Section {
            SandwichedImageSlider(interval: $single.interval,
                                  min: 0.001, max: 2.0)
        } header: {
            Text("Speed")
        }
        
        Section {
            RandomGradientView(colors: $single.colors, type: $single.gradientType)
        } header: {
            Text("Gradation")
        }
    }
}
