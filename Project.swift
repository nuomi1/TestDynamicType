import ProjectDescription

let project = Project(
    name: "TestDynamicType",
    targets: [
        .target(
            name: "TestDynamicType",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.TestDynamicType",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["TestDynamicType/Sources/**"],
            resources: ["TestDynamicType/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "TestDynamicTypeTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.TestDynamicTypeTests",
            infoPlist: .default,
            sources: ["TestDynamicType/Tests/**"],
            resources: [],
            dependencies: [.target(name: "TestDynamicType")]
        ),
    ]
)
