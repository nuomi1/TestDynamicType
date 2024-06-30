//
//  TripListItemView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-26.
//

import Foundation
import SwiftUI

struct TripListItemView: View {

    let trip: Trip

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundStyle(trip.color.color)

                Image(systemName: trip.icon)
            }
            .frame(width: 30, height: 30)

            Text(trip.title)
                .bold()
        }
    }
}
