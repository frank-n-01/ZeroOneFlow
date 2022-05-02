// Copyright © 2022 Ni Fu. All rights reserved.

import SwiftUI

struct ScreenSizeGetter: View {
    @Binding var height: CGFloat
    @Binding var width: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            Text("")
                .onAppear {
                    height = geometry.size.height
                    width = geometry.size.width
                }
                .onChange(of: geometry.size) { _ in
                    height = geometry.size.height
                    width = geometry.size.width
                }
        }
    }
}
