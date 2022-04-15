// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "starter-kit",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
         .package(url: "https://github.com/AndrewBarba/swift-compute-runtime", branch: "main"),
         .package(url: "https://github.com/swift-cloud/SwiftGD", branch: "main"),
    ],
    targets: [
        .executableTarget(
            name: "Hello",
            dependencies: [.product(name: "Compute", package: "swift-compute-runtime")]
        ),
        .executableTarget(
            name: "Image",
            dependencies: [.product(name: "Compute", package: "swift-compute-runtime"), "SwiftGD"]
        ),
        .executableTarget(
            name: "Proxy",
            dependencies: [.product(name: "Compute", package: "swift-compute-runtime")]
        ),
        .executableTarget(
            name: "Rest",
            dependencies: [.product(name: "Compute", package: "swift-compute-runtime")]
        )
    ]
)
