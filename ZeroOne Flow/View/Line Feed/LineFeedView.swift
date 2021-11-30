// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct LineFeedView: View {
    @Binding var linefeed: LineFeed
    let min: Double
    let max: Double
    
    var body: some View {
        Section {
            lengthSlider
            lineFeedToggle
        } header: {
            Text("LineFeed")
        }
    }
    
    private var lineFeedToggle: some View {
        Toggle(isOn: $linefeed.isOn) {
            Text("Activate")
                .font(.title3)
        }
    }
    
    private var lengthSlider: some View {
        HStack(spacing: 10) {
            Image(systemName: "ruler.fill")
                .font(.title3)
                .foregroundColor(.gray)
            Slider(value: $linefeed.maxLineLengthDouble, in: min...max) { editing in
                if !editing {
                    linefeed.maxLineLength = Int(linefeed.maxLineLengthDouble)
                }
            }
        }
    }
}
