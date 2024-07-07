//
//  TestDynamicTypeApp.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-26.
//

import Combine
import Foundation
import SwiftData
import SwiftUI

@main
struct TestDynamicTypeApp: App {

    @State
    private var dynamicTypeSize: DynamicTypeSize?

    var body: some Scene {
        WindowGroup {
            figureTabView

            // tripTabView
        }
        .modelContainer(for: [Trip.self])
    }

    @ViewBuilder
    private var figureTabView: some View {
        TabView {
            FigureTabContentView(configuration: Constants.Tab.swiftUI)

            FigureTabContentView(configuration: Constants.Tab.uiKit)
        }
        .observeContentSizeCategory(isEnabled: true, dynamicTypeSize: $dynamicTypeSize)
    }

    @ViewBuilder
    private var tripTabView: some View {
        TabView {
            TripTabContentView(configuration: Constants.Tab.swiftUI) { trip in
                SwiftUITripDetailView(trip: trip)
            }

            TripTabContentView(configuration: Constants.Tab.uiKit) { trip in
                UIKitTripDetailView(trip: trip)
            }
        }
    }
}

extension View {

    @ViewBuilder
    fileprivate func observeContentSizeCategory(isEnabled: Bool, dynamicTypeSize: Binding<DynamicTypeSize?>) -> some View {
        if isEnabled {
            onAppear {
                let sizeCategory = UITraitCollection.current.preferredContentSizeCategory
                dynamicTypeSize.wrappedValue = .init(sizeCategory)
            }
            .onChange(of: dynamicTypeSize.wrappedValue) { _, _ in
                printFont(dynamicTypeSize: dynamicTypeSize.wrappedValue!)
            }
            .onReceive(publisher) { notification in
                let sizeCategory = notification.userInfo![UIContentSizeCategory.newValueUserInfoKey]! as! UIContentSizeCategory
                dynamicTypeSize.wrappedValue = .init(sizeCategory)
            }
        }
    }

    private var publisher: NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: UIContentSizeCategory.didChangeNotification)
    }

    private func printFont(dynamicTypeSize: DynamicTypeSize) {
        dump(dynamicTypeSize)

        print("SwiftUI")

        for font in Constants.Font.swiftUI {
            print(font)
        }

        print("UIKit")

        for font in Constants.Font.uiKit {
            print(font)
        }
    }

    @ViewBuilder
    func debugBorder(isEnabled: Bool, color: Color = .red) -> some View {
        if isEnabled {
            border(color, width: 1)
        }
    }
}

extension UIView {

    func debugBorder(isEnabled: Bool, color: UIColor = .red) {
        if isEnabled {
            layer.borderColor = color.cgColor
            layer.borderWidth = 1
        }
    }
}
