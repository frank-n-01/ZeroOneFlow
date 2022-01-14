// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

/// Linear mode's home view. Customize the parameters of the flow.
struct LinearHome: View {
    @ObservedObject var linear: LinearViewModel
    
    var body: some View {
        FontView(fonts: $linear.fonts,
                 minSize: 10, maxSize: 200,
                 isRandom: false)
        
        ColorView(colors: $linear.colors, random: true)
        
        ContentTypeView(contents: $linear.contents)
        
        Section {
            SandwichedImageSlider(interval: $linear.interval,
                                  min: 0.001, max: 1.0)
            ToggleWithLabel(value: $linear.repeatFlow,
                            label: "Repeat")
        } header: {
            Text("Speed")
        }
        
        TextFormatView(format: $linear.linefeed,
                       min: 0, max: 100,
                       header: "LineFeed", image: "ruler.fill")
        
        TextFormatView(format: $linear.indents,
                       min: 0, max: 50,
                       header: "Indent", image: "list.bullet.indent")
    }
}
