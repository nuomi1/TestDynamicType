//
//  UIKitTripDetailView+Comment.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-30.
//

import Foundation
import UIKit

extension UIKitTripDetailView.UIKitTripDetailViewController {

    class CommentView: UIView, UIContentView {

        var configuration: any UIContentConfiguration {
            didSet {
                updateContentConfiguration(configuration as! ContentConfiguration)
            }
        }

        private let stackView = UIStackView()
        private let unreadIndicator = UIView()
        private let messageLabel = RoundedLabel()
        private let favoriteButton = UIButton()
        private let replyButton = UIButton()
        private let contactLabel = UILabel()

        init(configuration: ContentConfiguration) {
            self.configuration = configuration
            super.init(frame: .zero)
            prepare()
            updateContentConfiguration(configuration)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func prepare() {
            // stackView

            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.spacing = 8

            stackView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 8),
                stackView.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor, constant: 8),
                stackView.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor, constant: -8),
            ])

            // unreadIndicator

            unreadIndicator.backgroundColor = .systemBlue
            unreadIndicator.layer.cornerRadius = 5

            unreadIndicator.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(unreadIndicator)
            NSLayoutConstraint.activate([
                unreadIndicator.widthAnchor.constraint(equalToConstant: 10),
                unreadIndicator.heightAnchor.constraint(equalToConstant: 10),
            ])

            // messageLabel

            messageLabel.backgroundColor = .quaternaryLabel
            messageLabel.contentInsets = .init(top: 3, leading: 6, bottom: 3, trailing: 6)
            messageLabel.layer.cornerRadius = 6
            messageLabel.layer.masksToBounds = true

            stackView.addArrangedSubview(messageLabel)

            // spacer

            stackView.addArrangedSubview(UIView())

            // favoriteButton

            favoriteButton.configuration = .borderless()
            favoriteButton.tintColor = UIColor(.yellow.mix(with: .orange, by: 0.15))

            favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)

            stackView.addArrangedSubview(favoriteButton)

            // replyButton

            replyButton.configuration = .borderless()
            replyButton.configuration?.image = UIImage(systemName: "arrowshape.turn.up.left")

            replyButton.addTarget(self, action: #selector(createReply), for: .touchUpInside)

            stackView.addArrangedSubview(replyButton)

            // contactLabel

            contactLabel.translatesAutoresizingMaskIntoConstraints = false
            addSubview(contactLabel)
            NSLayoutConstraint.activate([
                contactLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
                contactLabel.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor),
                contactLabel.trailingAnchor.constraint(lessThanOrEqualTo: stackView.trailingAnchor),
                contactLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -8),
            ])
        }

        private func updateContentConfiguration(_ configuration: ContentConfiguration) {
            // unreadIndicator

            unreadIndicator.alpha = configuration.comment.isUnread ? 1 : 0

            // messageLabel

            messageLabel.text = configuration.comment.message

            // favoriteButton

            favoriteButton.configuration?.image = UIImage(systemName: configuration.comment.reaction.image)
            favoriteButton.configuration?.preferredSymbolConfigurationForImage = .init(weight: configuration.comment.reaction == .superFavorite ? .bold : .regular)

            // contactLabel

            contactLabel.text = configuration.comment.contact
        }

        @objc
        private func toggleFavorite() {
            let configuration = configuration as! ContentConfiguration
            let comment = configuration.comment

            switch comment.reaction {
            case .none:
                comment.reaction = .favorite
            case .favorite:
                comment.reaction = .superFavorite
            case .superFavorite:
                comment.reaction = .none
            }

            self.configuration = configuration // force refresh
        }

        @objc
        private func createReply() {
            let configuration = configuration as! ContentConfiguration
            let comment = configuration.comment

            Comment.makeReply(for: comment).map { reply in
                var replies = comment.replies
                replies.append(reply)
                comment.replies = replies
            }
        }
    }
}

extension UIKitTripDetailView.UIKitTripDetailViewController.CommentView {

    struct ContentConfiguration: UIContentConfiguration {

        let comment: Comment

        func makeContentView() -> any UIView & UIContentView {
            let contentView = UIKitTripDetailView.UIKitTripDetailViewController.CommentView(configuration: self)
            return contentView
        }

        func updated(for state: any UIConfigurationState) -> ContentConfiguration {
            self
        }
    }
}
