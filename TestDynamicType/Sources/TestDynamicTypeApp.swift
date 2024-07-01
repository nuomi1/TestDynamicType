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
            // tabView

            text
        }
        .modelContainer(for: [Trip.self])
    }

    @ViewBuilder
    private var tabView: some View {
        TabView {
            TripTabContentView(configuration: Constants.Tab.swiftUI) { trip in
                SwiftUITripDetailView(trip: trip)
            }

            TripTabContentView(configuration: Constants.Tab.uiKit) { trip in
                UIKitTripDetailView(trip: trip)
            }
        }
    }

    @ViewBuilder
    private var text: some View {
        let text = String(repeating: "Hello, World! ", count: 10)

        VStack {
            Text(text)
                .font(.body)

            UIKitLabel(text: text, font: .preferredFont(forTextStyle: .body))
        }
        .onAppear {
            let sizeCategory = UITraitCollection.current.preferredContentSizeCategory
            dynamicTypeSize = .init(sizeCategory)
        }
        .onChange(of: dynamicTypeSize) { _, _ in
            printFont()
        }
        .onReceive(publisher) { notification in
            let sizeCategory = notification.userInfo![UIContentSizeCategory.newValueUserInfoKey]! as! UIContentSizeCategory
            dynamicTypeSize = .init(sizeCategory)
        }
    }

    private var publisher: NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: UIContentSizeCategory.didChangeNotification)
    }

    private func printFont() {
        dump(dynamicTypeSize!)

        print("SwiftUI")

        for font in Constants.Font.swiftUI {
            print(font)
        }

        print("UIKit")

        for font in Constants.Font.uiKit {
            print(font)
        }
    }
}
