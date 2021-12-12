// The MIT License (MIT)
//
// Copyright (c) 2021 Jinya (https://github.com/Jinya).

import SwiftUI
import BetterListPicker

enum Framework: String, CaseIterable {
    case appKit = "AppKit"
    case uiKit = "UIKit"
    case swiftUI = "SwiftUI"
    case reactNative = "React Native"
}

extension Framework: BetterListPickerSelectable, Identifiable {
    var id: String { rawValue }
    var title: String { rawValue }
}

struct ContentView: View {
    @State private var favorite: Framework = .swiftUI

    var body: some View {
        NavigationView {
            List {
                betterListPickerSection()
                systemListPickerSection()
            }
            .navigationTitle("Picker Demo")
        }
        #if os(iOS)
        .navigationViewStyle(.stack)
        #endif
    }
}

extension ContentView {
    @ViewBuilder
    private func betterListPickerSection() -> some View {
        Section {
            BetterListPicker("Favorite Framework",
                             selection: $favorite,
                             pickerData: Framework.allCases)

            BetterListPicker("Favorite Framework",
                             selection: $favorite,
                             pickerData: Framework.allCases,
                             header: { Text("Header") },
                             footer: { EmptyView() })

            BetterListPicker($favorite,
                             pickerData: Framework.allCases) {
                Text("NavTitle1")
            } footer: {
                Text("Footer")
            } label: {
                Label("Favorite Framework", systemImage: "star.circle")
            }

            BetterListPicker($favorite,
                             pickerData: Framework.allCases) {
                Text("NavTitle2")
            } header: {
                Text("Header")
            } footer: {
                Text("Footer")
            } label: {
                VStack(alignment: .leading) {
                    Text("Favorite Framework")
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

    @ViewBuilder
    private func systemListPickerSection() -> some View {
        Section {
            Picker("Favorite Framework", selection: $favorite) {
                ForEach(Framework.allCases, id: \.self) { framework in
                    Text(framework.title)
                }
            }
        } header: {
            Text("SwiftUI Built-In Picker")
        } footer: {
            Text("Unable to customzie picker list style to `.insetGroupStyle`")
        }
        .headerProminence(.increased)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
