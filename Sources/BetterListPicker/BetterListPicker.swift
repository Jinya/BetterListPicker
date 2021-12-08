// The MIT License (MIT)
//
// Copyright (c) 2021 Jinya (https://github.com/Jinya).

import SwiftUI

@available(iOS 14.0, macOS 14.0, watchOS 7.0, tvOS 14.0, *)
public protocol BetterListPickerValuable: Identifiable, Equatable {
    var titleKey: LocalizedStringKey { get }
}

@available(iOS 14.0, macOS 14.0, watchOS 7.0, tvOS 14.0, *)
public struct BetterListPicker<Value: BetterListPickerValuable,
                               Label: View,
                               NavigationTitleLabel: View,
                               ListSectionHeader: View,
                               ListSectionFooter: View>: View {
    private var selectionValue: Binding<Value>
    private let pickerValues: [Value]

    private let navigationTitleLabel: NavigationTitleLabel
    private let header: ListSectionHeader
    private let footer: ListSectionFooter

    private let label: Label

    public var body: some View {
        NavigationLink {
            pickerList
            #if os(iOS) || os(watchOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        navigationTitleLabel
                    }
                }
        } label: {
            navigationLinkLabel
        }
    }

    private var navigationLinkLabel: some View {
        HStack {
            label
            Spacer()
            Text(selectionValue.wrappedValue.titleKey)
                .foregroundColor(.secondary)
        }
    }

    private var pickerList: some View {
        List {
            Section {
                ForEach(pickerValues) { value in
                    Button {
                        updateSelection(value)
                    } label: {
                        HStack {
                            Text(value.titleKey)
                                .foregroundColor(.primary)
                            Spacer()
                            if selectionValue.wrappedValue == value {
                                Image(systemName: "checkmark")
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

    private func updateSelection(_ value: Value) {
        guard value != selectionValue.wrappedValue else { return }
        selectionValue.wrappedValue = value
    }
}

// MARK: - General Picker Initializer

extension BetterListPicker {
    public init(_ selectionValue: Binding<Value>,
                pickerValues: [Value],
                navigationTitleLabel: () -> NavigationTitleLabel,
                pickerListSectionHeader: () -> ListSectionHeader,
                pickerListSectionFooter: () -> ListSectionFooter,
                label: () -> Label) {
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.navigationTitleLabel = navigationTitleLabel()
        self.header = pickerListSectionHeader()
        self.footer = pickerListSectionFooter()
        self.label = label()
    }

    public init(_ selectionValue: Binding<Value>,
                pickerValues: [Value],
                navigationTitleLabel: () -> NavigationTitleLabel,
                label: () -> Label)
    where ListSectionHeader == EmptyView,
    ListSectionFooter == EmptyView {
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.navigationTitleLabel = navigationTitleLabel()
        self.header = EmptyView()
        self.footer = EmptyView()
        self.label = label()
    }

    public init(_ selectionValue: Binding<Value>,
                pickerValues: [Value],
                navigationTitleLabel: () -> NavigationTitleLabel,
                pickerListSectionHeader: () -> ListSectionHeader,
                label: () -> Label)
    where ListSectionFooter == EmptyView {
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.navigationTitleLabel = navigationTitleLabel()
        self.header = pickerListSectionHeader()
        self.footer = EmptyView()
        self.label = label()
    }

    public init(_ selectionValue: Binding<Value>,
                pickerValues: [Value],
                navigationTitleLabel: () -> NavigationTitleLabel,
                pickerListSectionFooter: () -> ListSectionFooter,
                label: () -> Label)
    where ListSectionHeader == EmptyView {
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.navigationTitleLabel = navigationTitleLabel()
        self.header = EmptyView()
        self.footer = pickerListSectionFooter()
        self.label = label()
    }
}

// MARK: - Picker Initializer When `Label` and `NavigationTitleLabel` are `Text`

extension BetterListPicker where Label == Text, NavigationTitleLabel == Text {

    // MARK: - titleKey

    public init(_ titleKey: LocalizedStringKey,
                selectionValue: Binding<Value>,
                pickerValues: [Value],
                pickerListSectionHeader: () -> ListSectionHeader,
                pickerListSectionFooter: () -> ListSectionFooter) {
        self.label = Text(titleKey)
        self.navigationTitleLabel = Text(titleKey)
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.header = pickerListSectionHeader()
        self.footer = pickerListSectionFooter()
    }

    public init(_ titleKey: LocalizedStringKey,
                selectionValue: Binding<Value>,
                pickerValues: [Value])
    where ListSectionHeader == EmptyView,
    ListSectionFooter == EmptyView {
        self.label = Text(titleKey)
        self.navigationTitleLabel = Text(titleKey)
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.header = EmptyView()
        self.footer = EmptyView()
    }

    public init(_ titleKey: LocalizedStringKey,
                selectionValue: Binding<Value>,
                pickerValues: [Value],
                pickerListSectionHeader: () -> ListSectionHeader)
    where ListSectionFooter == EmptyView {
        self.label = Text(titleKey)
        self.navigationTitleLabel = Text(titleKey)
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.header = pickerListSectionHeader()
        self.footer = EmptyView()
    }

    public init(_ titleKey: LocalizedStringKey,
                selectionValue: Binding<Value>,
                pickerValues: [Value],
                pickerListSectionHeader: () -> ListSectionHeader,
                pickerListSectionFooter: () -> ListSectionFooter)
    where ListSectionHeader == EmptyView {
        self.label = Text(titleKey)
        self.navigationTitleLabel = Text(titleKey)
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.header = EmptyView()
        self.footer = pickerListSectionFooter()
    }

    // MARK: - title

    @_disfavoredOverload
    public init<S>(_ title: S,
                selectionValue: Binding<Value>,
                pickerValues: [Value],
                pickerListSectionHeader: () -> ListSectionHeader,
                pickerListSectionFooter: () -> ListSectionFooter)
    where S: StringProtocol {
        self.label = Text(title)
        self.navigationTitleLabel = Text(title)
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.header = pickerListSectionHeader()
        self.footer = pickerListSectionFooter()
    }

    @_disfavoredOverload
    public init<S>(_ title: S,
                selectionValue: Binding<Value>,
                pickerValues: [Value])
    where S: StringProtocol,
    ListSectionHeader == EmptyView,
    ListSectionFooter == EmptyView {
        self.label = Text(title)
        self.navigationTitleLabel = Text(title)
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.header = EmptyView()
        self.footer = EmptyView()
    }

    @_disfavoredOverload
    public init<S>(_ title: S,
                selectionValue: Binding<Value>,
                pickerValues: [Value],
                pickerListSectionHeader: () -> ListSectionHeader)
    where S: StringProtocol, ListSectionFooter == EmptyView {
        self.label = Text(title)
        self.navigationTitleLabel = Text(title)
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.header = pickerListSectionHeader()
        self.footer = EmptyView()
    }

    @_disfavoredOverload
    public init<S>(_ title: S,
                selectionValue: Binding<Value>,
                pickerValues: [Value],
                pickerListSectionFooter: () -> ListSectionFooter)
    where S: StringProtocol, ListSectionHeader == EmptyView {
        self.label = Text(title)
        self.navigationTitleLabel = Text(title)
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.header = EmptyView()
        self.footer = pickerListSectionFooter()
    }
}
