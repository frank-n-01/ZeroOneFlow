// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct ContentView: View {
    var body: some View {
        FlowModeHome()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModeUserDefaults())
    }
}
