//
//  TabContentView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-07.
//

import Foundation
import SwiftUI

struct TabContentView<Sidebar: View, Detail: View>: View {

    typealias Configuration = TabContentViewConfiguration

    private let configuration: Configuration
    private let sidebar: Sidebar
    private let detail: Detail

    init(
        configuration: Configuration,
        @ViewBuilder sidebar: () -> Sidebar,
        @ViewBuilder detail: () -> Detail
    ) {
        self.configuration = configuration
        self.sidebar = sidebar()
        self.detail = detail()
    }

    var body: some View {
        NavigationSplitView {
            sidebar
                .navigationTitle(configuration.navigationTitle)
        } detail: {
            detail
        }
        .tabItem {
            Label(configuration.tabTitle, systemImage: configuration.tabIcon)
        }
    }
}

struct TabContentViewConfiguration: Hashable {
    var tabTitle: String
    var tabIcon: String
    var navigationTitle: String
}
