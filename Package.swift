// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "starter-kit",
    platforms: [
        .macOS(.v11)
    ],
    dependencies: [
        .package(url: "https://github.com/swift-cloud/Compute", branch: "main"),
        .package(url: "https://github.com/TokamakUI/Tokamak", from: "0.11.1")
    ],
    targets: [
        .executableTarget(
            name: "Fetch",
            dependencies: ["Compute"]
        ),
        .executableTarget(
            name: "Hello",
            dependencies: ["Compute"]
        ),
        .executableTarget(
            name: "Proxy",
            dependencies: ["Compute"]
        ),
        .executableTarget(
            name: "Rest",
            dependencies: ["Compute"]
        ),
        .executableTarget(
            name: "Tokamak",
            dependencies: [
                "Compute",
                .product(name: "TokamakStaticHTML", package: "Tokamak")
            ]
        )
    ]
)
