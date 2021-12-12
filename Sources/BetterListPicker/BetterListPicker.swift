// The MIT License (MIT)
//
// Copyright (c) 2021 Jinya (https://github.com/Jinya).

import SwiftUI

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public protocol BetterListPickerSelectable {
    var title: String { get }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct BetterListPicker<Label, Data, Header, Footer>: View
where Label: View,
      Data: RandomAccessCollection,
      Header: View, Footer: View,
      Data.Element: BetterListPickerSelectable & Identifiable & Equatable {

    public typealias NavigationTitleLabel = Text

    private var selection: Binding<Data.Element>
    private let pickerData: Data

    private let label: Label
    private let navigationTitleLabel: NavigationTitleLabel
    private let header: Header
    private let footer: Footer

    public var body: some View {
        NavigationLink {
            pickerList
                .navigationTitle(navigationTitleLabel)
            #if os(iOS) || os(watchOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
        } label: {
            navigationLinkLabel
        }
    }

    private var navigationLinkLabel: some View {
        HStack {
            label
            Spacer()
            Text(selection.wrappedValue.title)
                .foregroundColor(.secondary)
        }
    }

    private var pickerList: some View {
        Form {
            Section {
                ForEach(pickerData) { element in
                    Button {
                        changeSelection(element)
                    } label: {
                        HStack {
                            Text(element.title)
                                .foregroundColor(.primary)
                            Spacer()
                            if selection.wrappedValue == element {
                                Image(systemName: "checkmark")
                                    .font(.headline)
                            }
                        }
                    }
                }
            } header: {
                header
            } footer: {
                footer
            }
        }
    }

    private func changeSelection(_ newValue: Data.Element) {
        // Toggle selection
        guard newValue != selection.wrappedValue else { return }
        selection.wrappedValue = newValue
    }
}

// MARK: - General Picker Initializer

extension BetterListPicker {
    public init(_ selection: Binding<Data.Element>,
                pickerData: Data,
                navigationTitleLabel: () -> NavigationTitleLabel,
                header: () -> Header,
                footer: () -> Footer,
                label: () -> Label) {
        self.selection = selection
        self.pickerData = pickerData
        self.navigationTitleLabel = navigationTitleLabel()
        self.header = header()
        self.footer = footer()
        self.label = label()
    }

    public init(_ selection: Binding<Data.Element>,
                pickerData: Data,
                navigationTitleLabel: () -> NavigationTitleLabel,
                label: () -> Label)
    where Header == EmptyView,
    Footer == EmptyView {
        self.selection = selection
        self.pickerData = pickerData
        self.navigationTitleLabel = navigationTitleLabel()
        self.header = EmptyView()
        self.footer = EmptyView()
        self.label = label()
    }

    public init(_ selection: Binding<Data.Element>,
                pickerData: Data,
                navigationTitleLabel: () -> NavigationTitleLabel,
                header: () -> Header,
                label: () -> Label)
    where Footer == EmptyView {
        self.selection = selection
        self.pickerData = pickerData
        self.navigationTitleLabel = navigationTitleLabel()
        self.header = header()
        self.footer = EmptyView()
        self.label = label()
    }

    public init(_ selection: Binding<Data.Element>,
                pickerData: Data,
                navigationTitleLabel: () -> NavigationTitleLabel,
                footer: () -> Footer,
                label: () -> Label)
    where Header == EmptyView {
        self.selection = selection
        self.pickerData = pickerData
        self.navigationTitleLabel = navigationTitleLabel()
        self.header = EmptyView()
        self.footer = footer()
        self.label = label()
    }
}

// MARK: - Picker Initializer When `Label` is `Text`

extension BetterListPicker where Label == Text {

    // MARK: - titleKey

    public init(_ titleKey: LocalizedStringKey,
                selection: Binding<Data.Element>,
                pickerData: Data,
                header: () -> Header,
                footer: () -> Footer) {
        self.label = Text(titleKey)
        self.navigationTitleLabel = Text(titleKey)
        self.selection = selection
        self.pickerData = pickerData
        self.header = header()
        self.footer = footer()
    }

    public init(_ titleKey: LocalizedStringKey,
                selection: Binding<Data.Element>,
                pickerData: Data)
    where Header == EmptyView, Footer == EmptyView {
        self.label = Text(titleKey)
        self.navigationTitleLabel = Text(titleKey)
        self.selection = selection
        self.pickerData = pickerData
        self.header = EmptyView()
        self.footer = EmptyView()
    }

    public init(_ titleKey: LocalizedStringKey,
                selection: Binding<Data.Element>,
                pickerData: Data,
                header: () -> Header)
    where Footer == EmptyView {
        self.label = Text(titleKey)
        self.navigationTitleLabel = Text(titleKey)
        self.selection = selection
        self.pickerData = pickerData
        self.header = header()
        self.footer = EmptyView()
    }

    public init(_ titleKey: LocalizedStringKey,
                selection: Binding<Data.Element>,
                pickerData: Data,
                header: () -> Header,
                footer: () -> Footer)
    where Header == EmptyView {
        self.label = Text(titleKey)
        self.navigationTitleLabel = Text(titleKey)
        self.selection = selection
        self.pickerData = pickerData
        self.header = EmptyView()
        self.footer = footer()
    }

    // MARK: - title

    @_disfavoredOverload
    public init<S>(_ title: S,
                selection: Binding<Data.Element>,
                pickerData: Data,
                header: () -> Header,
                footer: () -> Footer)
    where S: StringProtocol {
        self.label = Text(title)
        self.navigationTitleLabel = Text(title)
        self.selection = selection
        self.pickerData = pickerData
        self.header = header()
        self.footer = footer()
    }

    @_disfavoredOverload
    public init<S>(_ title: S,
                selection: Binding<Data.Element>,
                pickerData: Data)
    where S: StringProtocol,
    Header == EmptyView,
    Footer == EmptyView {
        self.label = Text(title)
        self.navigationTitleLabel = Text(title)
        self.selection = selection
        self.pickerData = pickerData
        self.header = EmptyView()
        self.footer = EmptyView()
    }

    @_disfavoredOverload
    public init<S>(_ title: S,
                selection: Binding<Data.Element>,
                pickerData: Data,
                header: () -> Header)
    where S: StringProtocol, Footer == EmptyView {
        self.label = Text(title)
        self.navigationTitleLabel = Text(title)
        self.selection = selection
        self.pickerData = pickerData
        self.header = header()
        self.footer = EmptyView()
    }

    @_disfavoredOverload
    public init<S>(_ title: S,
                selection: Binding<Data.Element>,
                pickerData: Data,
                footer: () -> Footer)
    where S: StringProtocol, Header == EmptyView {
        self.label = Text(title)
        self.navigationTitleLabel = Text(title)
        self.selection = selection
        self.pickerData = pickerData
        self.header = EmptyView()
        self.footer = footer()
    }
}
