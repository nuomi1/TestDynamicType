//
//  UIKitTripDetailView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-30.
//

import Foundation
import SwiftUI
import UIKit

struct UIKitTripDetailView: View {

    let trip: Trip?

    var body: some View {
        UIKitTripDetailViewControllerRepresentable(trip: trip)
    }
}

extension UIKitTripDetailView {

    struct UIKitTripDetailViewControllerRepresentable: UIViewControllerRepresentable {

        typealias UIViewControllerType = UIKitTripDetailViewController

        let trip: Trip?

        func makeUIViewController(context: Context) -> UIViewControllerType {
            .init(trip: trip)
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            uiViewController.trip = trip
            uiViewController.applySnapshot()
        }
    }
}

extension UIKitTripDetailView {

    @MainActor
    class UIKitTripDetailViewController: UIViewController {

        enum Section: Hashable {
            case image
            case message(Comment.ID)
        }

        enum Item: Hashable {
            case image(Trip)
            case comment(Comment)
            case reply(Comment.Reply)
        }

        var trip: Trip?

        lazy var compositionalLayout = makeCompositionalLayout()
        lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        lazy var dataSource = makeDataSource()

        lazy var emptyView = UILabel()

        init(trip: Trip?) {
            self.trip = trip
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            // self

            // navigationController?.navigationBar.prefersLargeTitles = true
            // navigationItem.largeTitleDisplayMode = .always

            // collectionView

            collectionView.allowsSelection = false
            collectionView.backgroundColor = .clear
            collectionView.dataSource = dataSource

            collectionView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(collectionView)
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])

            // emptyView

            emptyView.text = "Select a trip"
            emptyView.textColor = .label

            emptyView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(emptyView)
            NSLayoutConstraint.activate([
                emptyView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
                emptyView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
            ])

            // self

            applySnapshot()
        }
    }
}
