// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct ContentTypeView: View {
    @Binding var contents: Contents
    
    var body: some View {
        Section() {
            typePicker
            detailPicker
        } header: {
            Text("Content")
        }
    }
    
    var typePicker: some View {
        Picker(selection: $contents.type) {
            ForEach(ContentType.allCases) { type in
                Text(type.name)
                    .font(CommonStyle.LABEL_FONT)
                    .tag(type)
            }
        } label: {
            Text("Type")
                .font(CommonStyle.LABEL_FONT)
        }
    }
    
    var detailPicker: some View {
        Group {
            switch contents.type {
            case .number:
                numberPicker
            case .language:
                languagePicker
            case .symbol:
                symbolPicker
            case .custom:
                customTextField
            case .code:
                codePicker
            }
        }
    }
    
    var numberPicker: some View {
        Picker(selection: $contents.number) {
            ForEach(NumberType.allCases) { number in
                Text(number.name)
                    .font(CommonStyle.LABEL_FONT)
                    .tag(number)
            }
        } label: {
            Text("Number")
                .font(CommonStyle.LABEL_FONT)
        }
    }
    
    var languagePicker: some View {
        Picker(selection: $contents.language) {
            ForEach(LanguageType.allCases) { language in
                Text(language.name)
                    .font(CommonStyle.LABEL_FONT)
                    .tag(language)
            }
        } label: {
            Text("Language")
                .font(CommonStyle.LABEL_FONT)
        }
    }
    
    var symbolPicker: some View {
        Picker(selection: $contents.symbol) {
            ForEach(SymbolType.allCases) { symbol in
                Text(symbol.name)
                    .font(CommonStyle.LABEL_FONT)
                    .tag(symbol)
            }
        } label: {
            Text("Symbol")
                .font(CommonStyle.LABEL_FONT)
        }
    }
    
    var customTextField: some View {
        ForEach(0 ..< 2) { index in
            TextField( index == 0 ? "First Content" : "Second Content",
                       text: $contents.customValue[index])
                .autocapitalization(.none)
        }
    }
    
    var codePicker: some View {
        Picker(selection: $contents.code) {
            ForEach(CodeType.allCases) { code in
                Text(code.name)
                    .font(CommonStyle.LABEL_FONT)
                    .tag(code)
            }
        } label: {
            Text("Code")
                .font(CommonStyle.LABEL_FONT)
        }
    }
}
