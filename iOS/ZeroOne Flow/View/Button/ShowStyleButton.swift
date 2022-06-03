// Copyright © 2022 Ni Fu. All rights reserved.

import SwiftUI

struct ShowStyleButton: View {
    @ObservedObject var viewModel: FlowModeViewModel
    @State private var isSheetPresent = false
    
    var body: some View {
        Button {
            isSheetPresent.toggle()
        } label: {
            Image(systemName: "doc")
                .font(CommonStyle.LABEL_FONT)
                .padding()
        }
        .sheet(isPresented: $isSheetPresent) {
            StyleList(viewModel: viewModel)
        }
    }
}
