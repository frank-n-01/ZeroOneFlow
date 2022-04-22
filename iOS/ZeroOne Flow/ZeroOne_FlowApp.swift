// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

@main
struct ZeroOne_FlowApp: App {
    @StateObject var mode = ModeUserDefaults()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              PersistenceController.shared.container.viewContext)
                .environmentObject(mode)
        }
    }
}
