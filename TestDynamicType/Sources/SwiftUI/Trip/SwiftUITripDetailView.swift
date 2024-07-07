//
//  SwiftUITripDetailView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-26.
//

import Foundation
import SwiftUI

struct SwiftUITripDetailView: View {

    let trip: Trip?

    private var sortedComments: [Comment] {
        trip?.comments.sorted { $0.contact < $1.contact } ?? []
    }

    var body: some View {
        if let trip {
            detailView(trip: trip)
        } else {
            Text("Select a trip")
                .navigationTitle("Trips")
        }
    }

    @ViewBuilder
    private func detailView(trip: Trip) -> some View {
        ScrollView {
            TripPostView(trip: trip)

            ForEach(sortedComments) { comment in
                TripCommentView(comment: comment)
                    .onAppear {
                        withAnimation(.spring.delay(0.5)) {
                            if comment.isUnread {
                                comment.isUnread = false
                            }
                        }
                    }
            }
        }
        .navigationTitle(trip.title)
        .toolbar {
            ShareLink(
                item: Image(trip.image),
                preview: SharePreview(trip.title, image: Image(trip.image))
            ) {
                Image(systemName: "square.and.arrow.up")
            }
        }
    }
}
