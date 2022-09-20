// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "starter-kit",
    platforms: [
        .macOS(.v11)
    ],
    dependencies: [
        .package(url: "https://github.com/AndrewBarba/Compute", branch: "main"),
        .package(url: "https://github.com/TokamakUI/Tokamak.git", branch: "main")
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
