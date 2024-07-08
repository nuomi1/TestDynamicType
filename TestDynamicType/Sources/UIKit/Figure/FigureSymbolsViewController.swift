//
//  FigureSymbolsViewController.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-08.
//

import Combine
import Foundation
import UIKit

class FigureSymbolsViewController: UIViewController {

    typealias Section = String

    struct Item: Hashable {
        let figure: Figure
        let sizeCategory: UIContentSizeCategory
    }

    let figures: [Figure]

    private lazy var compositionalLayout = makeCompositionalLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
    private lazy var dataSource = makeDataSource()
    private var cancellables: Set<AnyCancellable> = []

    init(figures: [Figure]) {
        self.figures = figures
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let sizeCategory = UITraitCollection.current.preferredContentSizeCategory

        setupCollectionView()
        setupConstraints()
        applySnapshot(figures: figures, sizeCategory: sizeCategory)

        NotificationCenter.default
            .publisher(for: UIContentSizeCategory.didChangeNotification)
            .sink { [weak self] notification in
                self?.sizeCategoryDidChange(notification)
            }
            .store(in: &cancellables)
    }

    private func setupCollectionView() {
        // collectionView

        collectionView.backgroundColor = .clear
        collectionView.dataSource = dataSource

        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        // collectionView

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func sizeCategoryDidChange(_ notification: Notification) {
        let sizeCategory = notification.userInfo![UIContentSizeCategory.newValueUserInfoKey]! as! UIContentSizeCategory

        // collectionView

        applySnapshot(figures: figures, sizeCategory: sizeCategory)
    }

    private func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return .list(using: listConfiguration)
    }

    private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, _, itemIdentifier in
            let contentConfiguration = FigureDynamicLayoutsItemView.ContentConfiguration(item: itemIdentifier)
            cell.contentConfiguration = contentConfiguration
        }
        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        return dataSource
    }

    private func applySnapshot(figures: [Figure], sizeCategory: UIContentSizeCategory) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(["figures"])
        for figure in figures {
            snapshot.appendItems([.init(figure: figure, sizeCategory: sizeCategory)], toSection: "figures")
        }
        dataSource.apply(snapshot)
    }
}

extension FigureSymbolsViewController {

    class FigureDynamicLayoutsItemView: UIView, UIContentView {

        var configuration: any UIContentConfiguration {
            didSet {
                updateContentConfiguration(configuration as! ContentConfiguration)
            }
        }

        private var label: UILabel!

        init(configuration: ContentConfiguration) {
            self.configuration = configuration
            super.init(frame: .zero)
            setupLabel()
            setupConstraints()
            updateContentConfiguration(configuration)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupLabel() {
            // label

            label = UILabel()
            label.adjustsFontForContentSizeCategory = true
            label.font = .preferredFont(forTextStyle: .body)
            label.numberOfLines = 0
            label.debugBorder(isEnabled: true)

            addSubview(label)
        }

        private func setupConstraints() {
            // label

            label.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: readableContentGuide.topAnchor),
                label.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
                label.bottomAnchor.constraint(equalTo: readableContentGuide.bottomAnchor),
            ])
        }

        private func updateContentConfiguration(_ configuration: ContentConfiguration) {
            // label

            label.attributedText = attributedText(figure: configuration.item.figure)
        }

        private func attributedText(figure: Figure) -> NSAttributedString {
            let attachment = NSTextAttachment()
            attachment.image = UIImage(
                systemName: figure.systemImage,
                withConfiguration: UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .body))
            )

            let attributedString = NSMutableAttributedString(attachment: attachment)
            attributedString.append(NSAttributedString(string: "    "))
            attributedString.append(NSAttributedString(string: figure.figureName))

            return attributedString
        }
    }
}

extension FigureSymbolsViewController.FigureDynamicLayoutsItemView {

    struct ContentConfiguration: UIContentConfiguration {

        let item: FigureSymbolsViewController.Item

        func makeContentView() -> any UIView & UIContentView {
            let contentView = FigureSymbolsViewController.FigureDynamicLayoutsItemView(configuration: self)
            return contentView
        }

        func updated(for state: any UIConfigurationState) -> ContentConfiguration {
            self
        }
    }
}
