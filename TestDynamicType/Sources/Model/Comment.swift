//
//  Comment.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-26.
//

import Foundation
import SwiftData

@Model
final class Comment: Identifiable {

    typealias ID = UUID

    @Attribute(.unique)
    var id: ID

    var contact: String
    var message: String
    var isUnread: Bool
    var reaction: Reaction
    var replies: [Reply]
    var trip: Trip?

    init(
        id: ID,
        contact: String,
        message: String,
        isUnread: Bool,
        reaction: Reaction,
        replies: [Reply],
        trip: Trip
    ) {
        self.id = id
        self.contact = contact
        self.message = message
        self.isUnread = isUnread
        self.reaction = reaction
        self.replies = replies
        self.trip = trip
    }
}

extension Comment {

    enum Reaction: Codable {
        case none
        case favorite
        case superFavorite

        var image: String {
            switch self {
            case .none:
                "star"
            case .favorite:
                "star.fill"
            case .superFavorite:
                "sparkles"
            }
        }
    }
}

extension Comment {

    struct Reply: Identifiable, Codable {

        typealias ID = UUID

        var id: ID = .init()
        var message: String
    }
}

// MARK: Generator

extension Comment {

    private static let commentMessages = [
        """
        Looks like a wonderful time.
        """: """
        Thanks!
        """,
        """
        Absolutely beautiful!
        """: """
        It was, I had so much fun.
        """,
        """
        Hope you wore sunscreen.
        """: """
        You know it!
        """,
    ]

    private static let contactNames = [
        "Kathy",
        "Nick",
        "Jack",
        "Beth",
        "Emily",
        "Andrew",
        "Cooper",
        "Eric",
        "Liz",
        "Patrick",
    ]

    static func makeComments(for trip: Trip) -> [Comment] {
        commentMessages.keys.shuffled().map { message in
            let contact = contactNames.randomElement()!
            return Comment(
                id: UUID(),
                contact: contact,
                message: message,
                isUnread: true,
                reaction: .none,
                replies: [],
                trip: trip
            )
        }
    }

    static func makeReply(for comment: Comment) -> Reply? {
        commentMessages[comment.message].map { message in
            Reply(message: message)
        }
    }
}
