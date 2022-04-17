// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "starter-kit",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
         .package(url: "https://github.com/AndrewBarba/swift-compute-runtime", branch: "main"),
         .package(url: "https://github.com/GoodNotes/CryptoSwift.git", branch: "swiftwasm-support"),
    ],
    targets: [
        .executableTarget(
            name: "Hello",
            dependencies: [.product(name: "Compute", package: "swift-compute-runtime")]
        ),
        .executableTarget(
            name: "Proxy",
            dependencies: [.product(name: "Compute", package: "swift-compute-runtime")]
        ),
        .executableTarget(
            name: "Rest",
            dependencies: [.product(name: "Compute", package: "swift-compute-runtime")]
        ),
        .executableTarget(
            name: "SlackCommand",
            dependencies: [
                .product(name: "Compute", package: "swift-compute-runtime"),
                .product(name: "CryptoSwift", package: "CryptoSwift"),
            ]
        ),
    ]
)
