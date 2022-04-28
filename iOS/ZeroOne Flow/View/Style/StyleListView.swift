// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct StyleListView: View {
    @EnvironmentObject var mode: ModeUserDefaults
    @ObservedObject var viewModel: FlowModeViewModel
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: Mode.allCases[ModeUserDefaults.sharedCurrentMode].entity,
        sortDescriptors: [NSSortDescriptor(keyPath: \FlowMode.date, ascending: false)]
    ) var styles: FetchedResults<FlowMode>
    
    var body: some View {
        List {
            Section {
                SaveStyleField(saveCoreData: saveCoreData)
            }
            Section {
                styleRows
            }
        }
        .toolbar {
            EditButton()
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Style")
    }
    
    var styleRows: some View {
        ForEach(styles, id: \.self) { style in
            HStack {
                Group {
                    if style.name ?? "" == "unnamed" {
                        Text(LocalizedStringKey(style.name ?? ""))
                    } else {
                        Text(style.name ?? "")
                    }
                }
                .font(CommonStyle.LABEL_FONT)
                
                Button(action: {
                    viewModel.applyCoreData(context, style)
                    mode.isRandomStyle = false
                }) { Spacer() }
            }
        }
        .onDelete(perform: remove)
        .onMove(perform: move)
    }
    
    func saveCoreData(name: String) {
        viewModel.saveCoreData(context, name)
    }
    
    func remove(at offsets: IndexSet) {
        guard !styles.isEmpty else { return }
        
        for index in offsets {
            context.delete(styles[index])
        }
        
        if context.hasChanges {
            try? context.save()
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        guard let source = source.first else { return }
        
        let tmp = styles[source].date
        
        if source < destination {
            styles[source].date = styles[destination - 1].date
            
            for i in (source + 1...destination - 1).reversed() {
                if i == source + 1 {
                    styles[i].date = tmp
                } else {
                    styles[i].date = styles[i - 1].date
                }
            }
        } else if source > destination {
            styles[source].date = styles[destination].date
            
            for i in destination...source - 1 {
                if i == source - 1 {
                    styles[i].date = tmp
                } else {
                    styles[i].date = styles[i + 1].date
                }
            }
        }
        
        if context.hasChanges {
            try? context.save()
        }
    }
}
