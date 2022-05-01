// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct SingleHome: View {
    @ObservedObject var single: SingleViewModel
    
    var body: some View {
        FontView(fonts: $single.fonts, minSize: 5,
                 maxSize: SingleViewModel.MAX_FONT_SIZE, isRandom: true)
        
        ColorView(colors: $single.colors)
        
        ContentTypeView(contents: $single.contents)
        
        Section {
            SandwichImageSlider(value: $single.interval, min: 0.001, max: 2.0)
        } header: {
            Text("Speed")
        }
        
        Section {
            RandomGradientView(type: $single.gradientType, isActivated: $single.colors.bgRandom)
        } header: {
            Text("Gradation")
        }
    }
}
