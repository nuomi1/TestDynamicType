//
//  UIKitTripDetailView+List.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-30.
//

import Foundation
import UIKit

extension UIKitTripDetailView.UIKitTripDetailViewController {

    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfiguration.showsSeparators = false
        return .list(using: listConfiguration)
    }

    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, _, itemIdentifier in
            switch itemIdentifier {
            case let .image(trip):
                let contentConfiguration = PostView.ContentConfiguration(trip: trip)
                cell.contentConfiguration = contentConfiguration
            case let .comment(comment):
                let contentConfiguration = CommentView.ContentConfiguration(comment: comment)
                cell.contentConfiguration = contentConfiguration
            case let .reply(reply):
                let contentConfiguration = ReplyView.ContentConfiguration(reply: reply)
                cell.contentConfiguration = contentConfiguration
            }
        }
        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        return dataSource
    }

    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        if let trip {
            // image
            snapshot.appendSections([.image])
            snapshot.appendItems([.image(trip)], toSection: .image)
            // comment
            for comment in trip.comments.sorted(by: { $0.contact < $1.contact }) {
                snapshot.appendSections([.message(comment.id)])
                snapshot.appendItems([.comment(comment)], toSection: .message(comment.id))
                // reply
                for reply in comment.replies {
                    snapshot.appendItems([.reply(reply)], toSection: .message(comment.id))
                }
            }
        }
        dataSource.apply(snapshot)
        emptyView.isHidden = trip != nil
        // navigationItem.title = trip?.title ?? "Trips"
    }
}
