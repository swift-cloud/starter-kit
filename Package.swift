// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "starter-kit",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
         .package(url: "https://github.com/AndrewBarba/swift-compute-runtime", from: "1.1.0"),
    ],
    targets: [
        .executableTarget(
            name: "Hello",
            dependencies: [.product(name: "Compute", package: "swift-compute-runtime")]
        )
    ]
)
