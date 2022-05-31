// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct StyleList: View {
    @EnvironmentObject var mode: ModeUserDefaults
    @ObservedObject var viewModel: FlowModeViewModel
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        entity: Mode.allCases[ModeUserDefaults.sharedCurrentMode].entity,
        sortDescriptors: [NSSortDescriptor(keyPath: \FlowMode.date, ascending: false)]
    ) var styles: FetchedResults<FlowMode>
    
    // The index of currently applied style.
    @State private var appliedIndex: Int?
    
    var body: some View {
        NavigationView {
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
                    .font(CommonStyle.LABEL_FONT)
                    .padding()
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Style")
        }
    }
    
    var styleRows: some View {
        ForEach(styles.indices, id: \.self) { i in
            HStack {
                Group {
                    if i == appliedIndex {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                    
                    if styles[i].name ?? "" == "unnamed" {
                        Text(LocalizedStringKey(styles[i].name ?? ""))
                    } else {
                        Text(styles[i].name ?? "")
                    }
                }
                .font(CommonStyle.LABEL_FONT)
                
                Button {
                    viewModel.applyCoreData(context, styles[i])
                    mode.isRandomStyle = false
                    appliedIndex = i
                } label: {
                    Spacer()
                }
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
        
        saveContext()
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
        
        saveContext()
    }
    
    private func saveContext() {
        guard context.hasChanges else { return }
        try? context.save()
    }
}
