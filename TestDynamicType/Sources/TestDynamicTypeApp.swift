//
//  TestDynamicTypeApp.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-26.
//

import Foundation
import SwiftData
import SwiftUI

@main
struct TestDynamicTypeApp: App {

    var body: some Scene {
        WindowGroup {
            TabView {
                TripTabContentView(configuration: Constants.Tab.swiftUI) { trip in
                    SwiftUITripDetailView(trip: trip)
                }
            }
        }
        .modelContainer(for: [Trip.self])
    }
}
