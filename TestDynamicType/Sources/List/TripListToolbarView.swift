//
//  TripListToolbarView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-26.
//

import Foundation
import SwiftData
import SwiftUI

struct TripListToolbarView: View {

    @Environment(\.self)
    private var environment
    @Environment(\.modelContext)
    private var modelContext

    var body: some View {
        Button(action: createNewTrip) {
            Image(systemName: "square.and.pencil")
        }
    }

    private func createNewTrip() {
        modelContext.insert(Trip.makeTrip(in: environment))
        try? modelContext.save()
    }
}
