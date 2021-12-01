// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

/// Linear mode's home view. Customize the parameters of the flow.
struct LinearHome: View {
    @ObservedObject var linear: LinearViewModel
    
    var body: some View {
        FontView(fonts: $linear.fonts, minSize: 10, maxSize: 200, isRandom: false)
        
        ColorView(colors: $linear.colors, random: true)
        
        ContentTypeView(contentType: $linear.contents)
        
        Section {
            SandwichedImageSlider(interval: $linear.interval, min: 0.001, max: 0.5)
            ToggleWithLabel(value: $linear.repeatFlow, label: "Repeat")
        } header: {
            Text("Speed")
        }
        
        LineFeedView(linefeed: $linear.linefeed, min: 1, max: 200)
    }
}
