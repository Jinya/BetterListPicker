// The MIT License (MIT)
//
// Copyright (c) 2021 Jinya (https://github.com/Jinya).

import SwiftUI
import BetterListPicker

enum Framework: String, CaseIterable {
    case appkit = "AppKit"
    case uikit = "UIKit"
    case swiftui = "SwiftUI"
}

extension Framework: BetterListPickerValuable {
    var id: String { self.rawValue }
    var titleKey: LocalizedStringKey { LocalizedStringKey(self.rawValue) }
}

struct ContentView: View {

    @State var favorite: Framework = .swiftui

    var body: some View {
        NavigationView {
            List {
                // System Picker
                Section {
                    Picker("Favorite", selection: $favorite) {
                        ForEach(Framework.allCases, id: \.self) { framework in
                            Text(framework.rawValue)
                        }
                    }
                } header: {
                    Text("System Picker")
                }
                .headerProminence(.increased)

                // BetterListPicker
                Section {
                    BetterListPicker("Favorite",
                                     selectionValue: $favorite,
                                     pickerValues: Framework.allCases)

                    BetterListPicker("Favorite",
                                     selectionValue: $favorite,
                                     pickerValues: Framework.allCases,
                                     pickerListSectionHeader: { Text("Header") },
                                     pickerListSectionFooter: { EmptyView() })

                    BetterListPicker($favorite,
                                     pickerValues: Framework.allCases) {
                        Text("Custom Navigation Title")
                    } pickerListSectionFooter: {
                        Text("Footer")
                    } label: {
                        Label("Favorite", systemImage: "star.circle")
                    }

                    BetterListPicker($favorite,
                                     pickerValues: Framework.allCases) {
                        Text("Custom Navigation Title 2")
                    } pickerListSectionHeader: {
                        Text("Header")
                    } pickerListSectionFooter: {
                        Text("Footer")
                    } label: {
                        VStack(alignment: .leading) {
                            Text("Favorite")
                            Text("Choose the favorite framework")
                                .font(.footnote)
                        }
                    }
                } header: {
                    Text("BetterListPicker")
                } footer: {
                    Text("And more customizable features...")
                }
                .headerProminence(.increased)
            }
            .navigationTitle("Picker Demo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
