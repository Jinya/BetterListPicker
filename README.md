# BetterListPicker

An alternative customizable list picker to replace built-in non customizable `Picker` when we write settings view codes.

## Demo

![Demo GIF](DEMO.gif)

## Requirements

iOS 14.0+, macOS 11.0+, tvOS 14.0+, watchOS 7.0+

## Installation

#### Swift Package Manager (Recommended)

- Xcode >  File > Swift Packages > Add Package Dependency
- Add `https://github.com/Jinya/BetterListPicker.git`
- Select "Exact Version" (recommend using the latest exact version)

## Sample Code

See more in Demo App...

```swift
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
                BetterListPicker("Favorite Framework",
                                 selection: $favorite,
                                 pickerData: Framework.allCases)
            }
            .navigationTitle("Demo")
        }
    }
}
```


## MIT License 

BetterListPicker released under the MIT license. See LICENSE for details.
