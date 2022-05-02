// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct LinearHome: View {
    @ObservedObject var linear: LinearViewModel
    
    var body: some View {
        FontView(fonts: $linear.fonts, minSize: 5, maxSize: 300)
        
        ColorView(colors: $linear.colors)
        
        ContentTypeView(contents: $linear.contents)
        
        Section {
            SandwichImageSlider(value: $linear.interval, min: 0.001, max: 1.0)
            ToggleWithLabel(value: $linear.isRepeat, label: "Repeat")
        } header: {
            Text("Speed")
        }
        
        TextFormatView(format: $linear.linefeed, min: 0, max: 100,
                       header: "LineFeed", image: "ruler.fill")
        
        TextFormatView(format: $linear.indents, min: 0, max: 50,
                       header: "Indent", image: "list.bullet.indent")
    }
}
