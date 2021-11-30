// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct SimpleImageButton: View {
    let image: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .font(.title2)
        }
        .padding()
    }
}
