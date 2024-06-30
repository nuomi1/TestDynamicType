//
//  Trip.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-26.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Trip: Identifiable {

    typealias ID = UUID
    typealias Color = CodableColor

    @Attribute(.unique)
    var id: ID

    var title: String
    var date: Date
    var icon: String
    var message: String
    var image: String
    var color: Color

    @Relationship(inverse: \Comment.trip)
    var comments: [Comment]

    init(
        id: ID,
        title: String,
        date: Date,
        icon: String,
        message: String,
        image: String,
        color: Color,
        comments: [Comment]
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.icon = icon
        self.message = message
        self.image = image
        self.color = color
        self.comments = comments
    }
}

// MARK: Generator

extension Trip {

    private static let tripNames = [
        "Weekend Adventure",
        "Morning Excursion",
        "Afternoon Expedition",
        "Summer Day Trip",
        "Outing With Friends",
    ]

    private static let tripIcons = [
        "beach.umbrella.fill",
        "water.waves",
        "drop.fill",
        "sailboat.fill",
        "sun.max.fill",
    ]

    private static let tripColors: [SwiftUI.Color] = [
        .red,
        .blue,
        .green,
        .purple,
        .indigo,
    ]

    private static let tripMessages = [
        """
        It was a beautiful weekend. The boats were even out and sailing across the harbor
        """,
        """
        What a great day out with friends. The sun was shining and the waves were so calm.
        """,
    ]

    private static let tripImages = [
        "beach_1",
        "beach_2",
        "beach_3",
        "beach_4",
        "beach_5",
        "beach_6",
        "beach_7",
        "beach_8",
        "beach_9",
    ]

    static func makeTrip(
        in environment: EnvironmentValues
    ) -> Trip {
        let name = tripNames.randomElement()!
        let icon = tripIcons.randomElement()!
        let color = tripColors.randomElement()!.resolve(in: environment).resolvedCodableColor
        let message = tripMessages.randomElement()!
        let image = tripImages.randomElement()!
        let trip = Trip(
            id: UUID(),
            title: name,
            date: Date(),
            icon: icon,
            message: message,
            image: image,
            color: color,
            comments: []
        )
        trip.comments.append(contentsOf: Comment.makeComments(for: trip))
        return trip
    }
}
