//
//  TripListView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-26.
//

import Foundation
import SwiftData
import SwiftUI

struct TripListView: View {

    let trips: [Trip]
    @Binding
    var selectedTrip: Trip?

    @Environment(\.modelContext)
    private var modelContext

    var body: some View {
        List(selection: $selectedTrip) {
            ForEach(trips, id: \.self) { trip in
                TripListItemView(trip: trip)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    delete(trip: trips[index])
                }
            }
        }
        .toolbar {
            TripListToolbarView()
        }
    }

    private func delete(trip: Trip) {
        modelContext.delete(trip)
        try? modelContext.save()
    }
}
