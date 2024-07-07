//
//  AnyUIRepresentableViewController.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-07.
//

import Foundation
import SwiftUI
import UIKit

struct AnyUIRepresentableViewController<ViewController: UIViewController>: UIViewControllerRepresentable {

    typealias UIViewControllerType = ViewController

    struct Configuration {
        var makeUIViewController: (Context) -> UIViewControllerType
        var updateUIViewController: (UIViewControllerType, Context) -> Void
    }

    private let configuration: Configuration

    init(configuration: Configuration) {
        self.configuration = configuration
    }

    func makeUIViewController(context: Context) -> UIViewControllerType {
        let viewController = configuration.makeUIViewController(context)
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        configuration.updateUIViewController(uiViewController, context)
    }
}
