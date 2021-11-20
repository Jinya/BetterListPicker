//
//  BetterListPicker.swift
//  BetterListPicker
//
//  Created by Jinya on 2021/11/20.
//

import SwiftUI

public protocol BetterListPickerValuable: Identifiable, Equatable {
    var titleKey: LocalizedStringKey { get }
}

public struct BetterListPicker< Value, Label, NavigationTitleLabel, PickerListSectionHeader, PickerListSectionFooter>: View where Value: BetterListPickerValuable, Label: View, NavigationTitleLabel: View, PickerListSectionHeader: View, PickerListSectionFooter: View {

    private var selectionValue: Binding<Value>
    private let pickerValues: [Value]

    private let navigationTitleLabel: NavigationTitleLabel
    private let header: PickerListSectionHeader
    private let footer: PickerListSectionFooter

    private let label: Label

    public var body: some View {
        NavigationLink {
            pickerList
                .navigationBarTitleDisplayMode(.inline)
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
                if let listHeader = header {
                    listHeader
                } else {
                    EmptyView()
                }
            } footer: {
                if let listFooter = footer {
                    listFooter
                } else {
                    EmptyView()
                }
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
                pickerListSectionHeader: () -> PickerListSectionHeader,
                pickerListSectionFooter: () -> PickerListSectionFooter,
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
                label: () -> Label) where PickerListSectionHeader == EmptyView, PickerListSectionFooter == EmptyView {
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
                pickerListSectionHeader: () -> PickerListSectionHeader,
                label: () -> Label) where PickerListSectionFooter == EmptyView {
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
                pickerListSectionFooter: () -> PickerListSectionFooter,
                label: () -> Label) where PickerListSectionHeader == EmptyView {
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

    // MARK: - title

    public init(_ title: String,
                selectionValue: Binding<Value>,
                pickerValues: [Value],
                pickerListSectionHeader: () -> PickerListSectionHeader,
                pickerListSectionFooter: () -> PickerListSectionFooter) {
        self.label = Text(title)
        self.navigationTitleLabel = Text(title)
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.header = pickerListSectionHeader()
        self.footer = pickerListSectionFooter()
    }

    public init(_ title: String,
                selectionValue: Binding<Value>,
                pickerValues: [Value]) where PickerListSectionHeader == EmptyView, PickerListSectionFooter == EmptyView {
        self.label = Text(title)
        self.navigationTitleLabel = Text(title)
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.header = EmptyView()
        self.footer = EmptyView()
    }

    public init(_ title: String,
                selectionValue: Binding<Value>,
                pickerValues: [Value],
                pickerListSectionHeader: () -> PickerListSectionHeader) where PickerListSectionFooter == EmptyView {
        self.label = Text(title)
        self.navigationTitleLabel = Text(title)
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.header = pickerListSectionHeader()
        self.footer = EmptyView()
    }

    public init(_ title: String,
                selectionValue: Binding<Value>,
                pickerValues: [Value],
                pickerListSectionFooter: () -> PickerListSectionFooter) where PickerListSectionHeader == EmptyView {
        self.label = Text(title)
        self.navigationTitleLabel = Text(title)
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.header = EmptyView()
        self.footer = pickerListSectionFooter()
    }

    // MARK: - titleKey

    public init(_ titleKey: LocalizedStringKey,
                selectionValue: Binding<Value>,
                pickerValues: [Value],
                pickerListSectionHeader: () -> PickerListSectionHeader,
                pickerListSectionFooter: () -> PickerListSectionFooter) {
        self.label = Text(titleKey)
        self.navigationTitleLabel = Text(titleKey)
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.header = pickerListSectionHeader()
        self.footer = pickerListSectionFooter()
    }

    public init(_ titleKey: LocalizedStringKey,
                selectionValue: Binding<Value>,
                pickerValues: [Value]) where PickerListSectionHeader == EmptyView, PickerListSectionFooter == EmptyView {
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
                pickerListSectionHeader: () -> PickerListSectionHeader) where PickerListSectionFooter == EmptyView {
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
                pickerListSectionHeader: () -> PickerListSectionHeader,
                pickerListSectionFooter: () -> PickerListSectionFooter) where PickerListSectionHeader == EmptyView {
        self.label = Text(titleKey)
        self.navigationTitleLabel = Text(titleKey)
        self.selectionValue = selectionValue
        self.pickerValues = pickerValues
        self.header = EmptyView()
        self.footer = pickerListSectionFooter()
    }

}

