//
//  TripTabContentView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-26.
//

import Foundation
import SwiftData
import SwiftUI

struct TripTabContentView<Detail: View>: View {

    typealias Configuration = TabContentViewConfiguration

    private let configuration: Configuration
    private let detail: (Trip?) -> Detail

    @Query(sort: \Trip.date, order: .reverse)
    private var trips: [Trip]
    @State
    private var selectedTrip: Trip?

    init(
        configuration: Configuration,
        @ViewBuilder detail: @escaping (Trip?) -> Detail
    ) {
        self.configuration = configuration
        self.detail = detail
    }

    var body: some View {
        NavigationSplitView {
            TripListView(trips: trips, selectedTrip: $selectedTrip)
                .navigationTitle(configuration.navigationTitle)
        } detail: {
            detail(selectedTrip)
        }
        .tabItem {
            Label(configuration.tabTitle, systemImage: configuration.tabIcon)
        }
    }
}

struct TabContentViewConfiguration: Hashable {
    var tabTitle: String
    var tabIcon: String
    var navigationTitle: String
}
