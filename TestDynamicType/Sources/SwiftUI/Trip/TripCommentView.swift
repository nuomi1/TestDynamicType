//
//  TripCommentView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-30.
//

import Foundation
import SwiftUI

struct TripCommentView: View {

    let comment: Comment

    var body: some View {
        VStack(alignment: .leading) {
            LabeledContent {
                CommentMessageView {
                    UnreadIndicatorView(isUnread: comment.isUnread)
                } title: {
                    Text(comment.message)
                }

                Spacer()

                Button(action: toggleFavorite) {
                    Image(systemName: comment.reaction.image)
                        .bold(comment.reaction == .superFavorite)
                        .foregroundStyle(.yellow.mix(with: .orange, by: 0.15))
                        .symbolEffect(.bounce, value: comment.reaction)
                }
                .buttonStyle(.borderless)

                Button(action: createReply) {
                    Image(systemName: "arrowshape.turn.up.left")
                }
                .buttonStyle(.borderless)
            } label: {
                Text(comment.contact)
            }
            .labeledContentStyle(CommentLabeledContentStyle())

            ForEach(comment.replies) { reply in
                Text(reply.message)
                    .modifier(CommentModifier(style: .quaternary))
                    .padding(.leading, 40)
            }
        }
        .padding(.horizontal)
    }

    private func toggleFavorite() {
        switch comment.reaction {
        case .none:
            comment.reaction = .favorite
        case .favorite:
            comment.reaction = .superFavorite
        case .superFavorite:
            comment.reaction = .none
        }
    }

    private func createReply() {
        Comment.makeReply(for: comment).map { reply in
            var replies = comment.replies
            replies.append(reply)
            comment.replies = replies
        }
    }
}
